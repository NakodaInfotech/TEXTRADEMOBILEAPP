package com.example.textrade

import com.google.gson.annotations.SerializedName
import com.logicsquare.pdfcreationtest.Table1


data class TableRes (

    @SerializedName("Table"  ) var Table  : ArrayList<Table>  = arrayListOf(),
    @SerializedName("Table1" ) var Table1 : ArrayList<Table1> = arrayListOf()

)