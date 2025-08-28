package com.example.textrade.ladger

import com.google.gson.annotations.SerializedName

data class LadgerTable(
    @SerializedName("ACCTYPE" ) var ACCTYPE : String? = null,
    @SerializedName("AMT"     ) var AMT     : Double?    = null,
    @SerializedName("DRCR"    ) var DRCR    : String? = null
)
