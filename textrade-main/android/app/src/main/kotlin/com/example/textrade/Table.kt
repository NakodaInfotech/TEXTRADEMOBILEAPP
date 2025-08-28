package com.example.textrade

import com.google.gson.annotations.SerializedName


data class Table (

  @SerializedName("PIECETYPE" ) var PIECETYPE : String? = null,
  @SerializedName("ITEMNAME"  ) var ITEMNAME  : String? = null,
  @SerializedName("DESIGNNO"  ) var DESIGNNO  : String? = null,
  @SerializedName("COLOR"     ) var COLOR     : String? = null,
  @SerializedName("UNIT"      ) var UNIT      : String? = null,
  @SerializedName("GODOWN"    ) var GODOWN    : String? = null,
  @SerializedName("PCS"       ) var PCS       : Double?    = null,
  @SerializedName("MTRS"      ) var MTRS      : Double?    = null,
  @SerializedName("ITEMID"    ) var ITEMID    : Double?    = null,
  @SerializedName("DESIGNID"  ) var DESIGNID  : Double?    = null,
  @SerializedName("COLORID"   ) var COLORID   : Double?    = null

)