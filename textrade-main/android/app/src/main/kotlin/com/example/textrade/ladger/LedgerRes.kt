package com.example.textrade.ladger

import com.google.gson.annotations.SerializedName

data class LedgerRes(
    @SerializedName("Table"  ) var Table  : ArrayList<LadgerTable>  = arrayListOf(),
    @SerializedName("Table1" ) var Table1 : ArrayList<LedgerTable1> = arrayListOf()
)