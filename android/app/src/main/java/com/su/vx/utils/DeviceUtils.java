package com.su.vx.utils;

import android.annotation.TargetApi;
import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Build;
import android.telephony.TelephonyManager;
import android.text.TextUtils;

import java.io.BufferedReader;
import java.io.FileReader;
import java.net.NetworkInterface;
import java.security.MessageDigest;
import java.util.Enumeration;
import java.util.Locale;

public class DeviceUtils {

    public static String getImei(Context context){
        String imei=null;
        try {
            TelephonyManager tm = (TelephonyManager) context.getApplicationContext()
                    .getSystemService(Context.TELEPHONY_SERVICE);
            imei = tm.getDeviceId();
        }catch (Exception e){
            e.printStackTrace();
        }
        return imei;
    }

    public static String getMac(Context context){
        String result = "";
        if (context == null) {
            return result;
        } else {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
                result = getMacBySystemInterface(context);
            } else if (Build.VERSION.SDK_INT == Build.VERSION_CODES.M) {
                result = getMacByJavaAPI();
                if (TextUtils.isEmpty(result)) {
                    result = getMacShell();
                }
            } else {
                result = getMacByJavaAPI();
                if (TextUtils.isEmpty(result)) {
                    result = getMacBySystemInterface(context);
                }
            }

            return result;
        }
    }

    private static String getMacBySystemInterface(Context context) {
        WifiManager wifiManager = (WifiManager) context.getApplicationContext().getSystemService(Context.WIFI_SERVICE);
        if (wifiManager != null) {
            WifiInfo wifiInfo = wifiManager.getConnectionInfo();
            return wifiInfo.getMacAddress();
        } else {
            return "";
        }
    }

    @TargetApi(Build.VERSION_CODES.GINGERBREAD)
    public static String getMacByJavaAPI() {
        try {
            Enumeration networkInterfaces = NetworkInterface.getNetworkInterfaces();

            NetworkInterface networkInterface;
            do {
                if (!networkInterfaces.hasMoreElements()) {
                    return null;
                }

                networkInterface = (NetworkInterface) networkInterfaces.nextElement();
            }
            while (!"wlan0".equals(networkInterface.getName()) && !"eth0".equals(networkInterface.getName()));

            byte[] hardwareAddress = networkInterface.getHardwareAddress();
            if (hardwareAddress != null && hardwareAddress.length != 0) {
                StringBuilder stringBuilder = new StringBuilder();
                for (int i = 0; i < hardwareAddress.length; ++i) {
                    stringBuilder.append(String.format("%02X:", hardwareAddress[i]));
                }

                if (stringBuilder.length() > 0) {
                    stringBuilder.deleteCharAt(stringBuilder.length() - 1);
                }

                return stringBuilder.toString().toLowerCase(Locale.getDefault());
            } else {
                return null;
            }
        } catch (Exception e) {
            return null;
        }
    }

    public static String getMacShell() {
        try {
            String[] result = new String[]{"/sys/class/net/wlan0/address", "/sys/class/net/eth0/address", "/sys/devices/virtual/net/wlan0/address"};

            for (int i = 0; i < result.length; ++i) {
                try {
                    String mac = reaMac(result[i]);
                    if (mac != null) {
                        return mac;
                    }
                } catch (Exception e) {

                }
            }
        } catch (Exception e) {
        }

        return null;
    }

    private static String reaMac(String filePath) {
        String result = null;

        FileReader fileReader = null;
        BufferedReader bufferedReader = null;
        try {
            fileReader = new FileReader(filePath);
            bufferedReader = new BufferedReader(new FileReader(filePath), 1024);
            result = bufferedReader.readLine();
        } catch (Exception e) {
        } finally {
            if (fileReader != null) {
                try {
                    fileReader.close();
                } catch (Exception e) {
                }
            }
            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (Exception e) {
                }
            }
        }
        return result;
    }

    public static String getMD5(String s) {
        char hexDigits[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
        try {
            byte[] btInput = s.getBytes();
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            mdInst.update(btInput);
            byte[] md = mdInst.digest();
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (byte byte0 : md) {
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(str);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public static boolean isNetworkConnected(Context context) {
        if (context != null) {
            ConnectivityManager mConnectivityManager = (ConnectivityManager) context
                    .getSystemService(Context.CONNECTIVITY_SERVICE);
            NetworkInfo mNetworkInfo = mConnectivityManager.getActiveNetworkInfo();
            if (mNetworkInfo != null) {
                return mNetworkInfo.isConnected();
            }
        }
        return false;
    }
}
