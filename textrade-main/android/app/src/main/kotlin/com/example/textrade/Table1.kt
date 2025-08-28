package com.logicsquare.pdfcreationtest

import com.google.gson.annotations.SerializedName


data class Table1 (

  @SerializedName("PCS"  ) var PCS  : Double?    = null,
  @SerializedName("MTRS" ) var MTRS : Double? = null

)