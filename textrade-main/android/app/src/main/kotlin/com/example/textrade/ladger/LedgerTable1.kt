package com.example.textrade.ladger

import com.google.gson.annotations.SerializedName

data class LedgerTable1(
    @SerializedName("DATE"    ) var DATE    : String? = null,
    @SerializedName("ACCTYPE" ) var ACCTYPE : String? = null,
    @SerializedName("BILLNO"  ) var BILLNO  : String? = null,
    @SerializedName("DESC"    ) var DESC    : String? = null,
    @SerializedName("AMT"     ) var AMT     : Double?    = null,
    @SerializedName("DRCR"    ) var DRCR    : String? = null

)
