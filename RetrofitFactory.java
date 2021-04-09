package com.personalized.theme.magic.api;


import com.personalized.theme.magic.config.URLConstant;

import java.io.IOException;
import java.util.concurrent.TimeUnit;

import okhttp3.Interceptor;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.logging.HttpLoggingInterceptor;
import retrofit2.Retrofit;
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory;


/**
 * Desc:   Retrofit工厂类
 * Author: Yang
 * Date:   2020/7/11 0011
 */
public class RetrofitFactory {


    private volatile static Retrofit retrofit;

    public static Retrofit getRetrofit() {
        if (retrofit == null) {


            HttpLoggingInterceptor logInterceptor = new HttpLoggingInterceptor(new HttpLogger());
            logInterceptor.setLevel(HttpLoggingInterceptor.Level.BODY);

            OkHttpClient.Builder builder = new OkHttpClient.Builder()
                    .addInterceptor(new PostJsonInterceptor())
                    .addInterceptor(new Interceptor() {
                        @Override
                        public Response intercept(Chain chain) throws IOException {
                            Request request = chain.request()
                                    .newBuilder()
                                    .addHeader("Content-Type", "application/json;charset=UTF-8")
                                    .build();
                            return chain.proceed(request);
                        }
                    })
                    .connectTimeout(URLConstant.NETWORK_OPEN_TIME, TimeUnit.SECONDS)
                    .readTimeout(URLConstant.NETWORK_READ_TIME, TimeUnit.SECONDS)
                    .writeTimeout(URLConstant.NETWORK_READ_TIME, TimeUnit.SECONDS)
                    .addNetworkInterceptor(logInterceptor)
                    .retryOnConnectionFailure(false);//出错不重试

            retrofit = new Retrofit.Builder()
                    .baseUrl(URLConstant.HOST)
                    .client(builder.build())
                    .addConverterFactory(CustomGsonConverterFactory.create())
                    .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
                    .build();
        }
        return retrofit;
    }
}
