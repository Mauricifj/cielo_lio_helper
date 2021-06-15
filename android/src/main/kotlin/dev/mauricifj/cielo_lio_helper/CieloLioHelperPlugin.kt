package dev.mauricifj.cielo_lio_helper

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.net.Uri
import android.os.BatteryManager
import android.util.Base64
import android.util.Log
import androidx.annotation.NonNull
import cielo.orders.domain.Credentials
import cielo.sdk.info.InfoManager
import cielo.sdk.order.OrderManager

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.*
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

private const val MESSAGES_CHANNEL = "cielo_lio_helper/messages"
private const val PRINT_RESPONSES_CHANNEL = "cielo_lio_helper/print_responses"
private const val PAYMENT_RESPONSES_CHANNEL = "cielo_lio_helper/payment_responses"
private const val REVERSAL_RESPONSES_CHANNEL = "cielo_lio_helper/reversal_responses"

private const val TAG = "CIELO_LIO_HELPER_TAG"

class CieloLioHelperPlugin: FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.NewIntentListener, EventChannel.StreamHandler {
  private var binding: ActivityPluginBinding? = null
  private var activity: Activity? = null
  private lateinit var applicationContext: Context

  private lateinit var channel : MethodChannel
  private var printSink: EventChannel.EventSink? = null
  private var paymentSink: EventChannel.EventSink? = null
  private var reversalSink: EventChannel.EventSink? = null

  override fun onListen(arguments: Any?, events: EventChannel.EventSink) {
    when (arguments) {
      "print_responses" -> printSink = events
      "payment_responses" -> paymentSink = events
      "reversal_responses" -> reversalSink = events
    }
  }

  override fun onCancel(arguments: Any?) {
    when (arguments) {
      "print_responses" -> printSink = null
      "payment_responses" -> paymentSink = null
      "reversal_responses" -> reversalSink = null
    }
  }

  private fun setupCallbackChannels(binaryMessenger: BinaryMessenger) {
    val printResponsesChannel = EventChannel(binaryMessenger, PRINT_RESPONSES_CHANNEL)
    printResponsesChannel.setStreamHandler(this)

    val paymentResponsesChannel = EventChannel(binaryMessenger, PAYMENT_RESPONSES_CHANNEL)
    paymentResponsesChannel.setStreamHandler(this)

    val reversalResponsesChannel = EventChannel(binaryMessenger, REVERSAL_RESPONSES_CHANNEL)
    reversalResponsesChannel.setStreamHandler(this)
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.applicationContext
    setupCallbackChannels(flutterPluginBinding.binaryMessenger)

    channel = MethodChannel(flutterPluginBinding.binaryMessenger, MESSAGES_CHANNEL)
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onDetachedFromActivity() {
    binding?.removeOnNewIntentListener(this)
    activity = null
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    binding.addOnNewIntentListener(this)
    handleIntent(binding.activity.intent, true)
    activity = binding.activity
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    binding.addOnNewIntentListener(this)
    handleIntent(binding.activity.intent, true)
    activity = binding.activity
  }

  override fun onDetachedFromActivityForConfigChanges() {
    this.binding?.removeOnNewIntentListener(this)
    activity = null
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    return if (call.hasArgument("uri") && call.argument<String>("uri") != null) {
      when (call.method) {
        "print" -> callLio(call.argument<String>("uri")!!)
        "payment" -> callLio(call.argument<String>("uri")!!)
        "reversal" -> callLio(call.argument<String>("uri")!!)
        "retrievePaymentType" -> {
          val clientId = call.argument<String>("clientId")
          val accessToken = call.argument<String>("accessToken")
          if (clientId == null) {
            result.error("id_null", "Id could not be null", null)
          }
          result.success(retrievePaymentType(clientId!!, accessToken!!))
        }
        "retrieveOrders" -> {
          val clientId = call.argument<String>("clientId")
          val accessToken = call.argument<String>("accessToken")
          val pageSize = call.argument<String>("pageSize")!!.toIntOrNull()
          val page = call.argument<String>("page")!!.toIntOrNull()
          result.success(retrieveOrders(clientId!!, accessToken!!, pageSize ?: 10, page ?: 0))
        }
        "retrieveOrderById" -> {
          val clientId = call.argument<String>("clientId")
          val accessToken = call.argument<String>("accessToken")
          val id = call.argument<String>("id")
          if (id == null) {
            result.error("id_null", "Id could not be null", null)
          }
          result.success(retrieveOrderById(clientId!!, accessToken!!, id!!))
        }
        else -> result.notImplemented()
      }
    } else {
      when (call.method) {
        "getEC" -> {
          val ec = getEC()
          if (ec == null) {
            result.error("ec_null", "Couldn't retrieve ec", null)
          }
          result.success(ec)
        }
        "getLogicNumber" -> {
          val logicNumber = getLogicNumber()
          if (logicNumber == null) {
            result.error("logic_number_null", "Couldn't retrieve logic number", null)
          }
          result.success(logicNumber)
        }
        "getBatteryLevel" -> {
          val batteryLevel = getBatteryLevel()
          if (batteryLevel == null) {
            result.error("battery_level_null", "Couldn't retrieve battery level", null)
          }
          result.success(batteryLevel)
        }
        else -> result.notImplemented()
      }
    }
  }

  private fun getEC() : String? {
    val ec = InfoManager().getSettings(applicationContext)?.merchantCode
    Log.d(TAG, "EC: $ec")
    return ec
  }

  private fun getLogicNumber() : String? {
    val logicNumber = InfoManager().getSettings(applicationContext)?.logicNumber
    Log.d(TAG, "LOGIC NUMBER: $logicNumber")
    return logicNumber
  }

  private fun getBatteryLevel() : Float? {
    val batteryStatus: Intent? = IntentFilter(Intent.ACTION_BATTERY_CHANGED).let { ifilter ->
      applicationContext.registerReceiver(null, ifilter)
    }

    val batteryPercentage: Float? = batteryStatus?.let { intent ->
      val level: Int = intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)
      val scale: Int = intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
      level * 100 / scale.toFloat()
    }

    return batteryPercentage ?: -1f
  }

  // TODO: FIND A BETTER WAY TO RECEIVE CLIENT ID AND ACCESS TOKEN
  private fun retrievePaymentType(clientId: String, accessToken: String) : String {
    val credentials = Credentials(clientId, accessToken)
    val orderManager = OrderManager(credentials, applicationContext)
    val paymentTypes = orderManager.retrievePaymentType(applicationContext)
    return paymentTypes.toString() // TODO: ADD SERIALIZATION
  }

  // TODO: FIND A BETTER WAY TO RECEIVE CLIENT ID AND ACCESS TOKEN
  private fun retrieveOrderById(clientId: String, accessToken: String, id: String): String {
    val credentials = Credentials(clientId, accessToken)
    val orderManager = OrderManager(credentials, applicationContext)
    return orderManager.retrieveOrderById(id).toString() // TODO: ADD SERIALIZATION
  }

  // TODO: FIND A BETTER WAY TO RECEIVE CLIENT ID AND ACCESS TOKEN
  private fun retrieveOrders(clientId: String, accessToken: String, pageSize: Int, page: Int): String {
    val credentials = Credentials(clientId, accessToken)
    val orderManager = OrderManager(credentials, applicationContext)
    return orderManager.retrieveOrders(pageSize, page).toString() // TODO: ADD SERIALIZATION
  }

  private fun callLio(uri: String) {
    Log.d(TAG, "CALLING LIO WITH URI: $uri")
    val i = Intent(Intent.ACTION_VIEW, Uri.parse(uri))
    i.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
    activity?.startActivity(i)
  }

  override fun onNewIntent(intent: Intent?): Boolean {
    if (intent != null) {
      handleIntent(intent, false)
    }
    return false
  }

  private fun handleIntent(intent: Intent, initial: Boolean) {
    if (intent.action == Intent.ACTION_VIEW) {
      val uri = intent.data
      when (uri?.scheme) {
        "print_response" -> {
          try {
            Log.d(TAG, "PRINT RESPONSE DATA: ${intent.data}")
            val json = extractJsonFromUri(uri)
            printSink?.success(json)
          } catch (e: Exception) {
            Log.e(TAG, "PRINT ERROR: ${e.message}", e)
          }
        }
        "payment_response" -> {
          try {
            Log.d(TAG, "PAYMENT RESPONSE DATA: ${intent.data}")
            val json = extractJsonFromUri(uri)
            Log.d(TAG, "PAYMENT RESPONSE JSON: $json")
            Log.d(TAG, "PAYMENT RESPONSE JSON LENGTH: ${json?.length}")
            paymentSink?.success(json)
          } catch (e: Exception) {
            Log.e(TAG, "PAYMENT ERROR: ${e.message}", e)
          }
        }
        "reversal_response" -> {
          try {
            Log.d(TAG, "REVERSAL RESPONSE DATA: ${intent.data}")
            val json = extractJsonFromUri(uri)
            reversalSink?.success(json)
          } catch (e: Exception) {
            Log.e(TAG, "REVERSAL ERROR: ${e.message}", e)
          }
        }
      }
    }
  }

  private fun extractJsonFromUri(uri: Uri?) : String? {
    try {
      val response = uri?.getQueryParameter("response")
      val data = Base64.decode(response, Base64.DEFAULT)
      val json = String(data)

      return json
    } catch (e: Exception) {
      Log.e(TAG, "ERROR EXTRACTING RESPONSE: ${e.message}", e)
      throw e
    }
  }
}
