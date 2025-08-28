package com.example.textrade

import com.google.gson.annotations.SerializedName
import com.logicsquare.pdfcreationtest.Table1

data class CompanyDetail(
    @SerializedName("CMPNAME") var CMPNAME  :String ,
    @SerializedName("CMPID" ) var CMPID : Int,
    @SerializedName("ADD1" ) var ADD1 :String ,
    @SerializedName("ADD2" ) var ADD2 : String,

)

