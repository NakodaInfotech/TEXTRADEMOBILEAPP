package com.example.textrade

import android.Manifest
import android.annotation.SuppressLint
import android.content.Context
import android.content.pm.PackageManager
import android.os.Bundle
import android.util.Log
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.content.ContextCompat
import com.example.textrade.ladger.LedgerRes
import com.google.gson.Gson
import com.itextpdf.text.*
import com.itextpdf.text.TabStop.Alignment
import com.itextpdf.text.html.WebColors
import com.itextpdf.text.pdf.BaseFont
import com.itextpdf.text.pdf.PdfPCell
import com.itextpdf.text.pdf.PdfPTable
import com.itextpdf.text.pdf.PdfWriter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileNotFoundException
import java.io.FileOutputStream
import java.io.IOException
import java.math.RoundingMode
import java.text.DecimalFormat
import java.text.SimpleDateFormat
import java.util.*


class MainActivity : FlutterActivity() {

    private lateinit var cell: PdfPCell
    var headColor: BaseColor = WebColors.getRGBColor("#DEDEDE")
    var tableHeadColor = WebColors.getRGBColor("#F5ABAB")
    private val PERMISSION_REQUEST_CODE = 200
    lateinit var tableRes: TableRes
    lateinit var ledgerRes: LedgerRes
    lateinit var companyDetail: CompanyDetail
    var pdfDate: String = ""
    var party_name: String = ""

    private var pcsTotal = 0.0
    private var mtrsTotal = 0.0


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)


    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.textrade.android/helper"
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getGeneratedPdfLocation" -> {


                    try {
                        var haspMAP = (call.arguments as HashMap<*, *>)

                        var jsonData = haspMAP["pdf_data"].toString()

                        var comDetail = haspMAP["company_detail"].toString()

                        pdfDate = haspMAP["pdf_date"].toString()


                        tableRes = Gson().fromJson(jsonData, TableRes::class.java)
                        companyDetail = Gson().fromJson(comDetail, CompanyDetail::class.java)

                        // var otherItemSize = tableRes.Table1.size

                        if (tableRes.Table1.size > 0) {
                            tableRes.Table1.forEach {

                                var table = Table()
                                table.ITEMNAME = ""
                                table.DESIGNNO = ""
                                table.COLOR = ""
                                table.UNIT = ""
                                table.GODOWN = ""
                                table.PCS = it.PCS
                                table.MTRS = it.MTRS
                                table.ITEMID = 0.0
                                table.DESIGNID = 0.0
                                table.COLORID = 0.0

                                //   Log.e("ocscs",it.PCS.toString())
                                //   Log.e("ocsfgtcs",it.MTRS.toString())

                                pcsTotal += it.PCS!!
                                mtrsTotal += it.MTRS!!
                                //  tableRes.Table.add(table)
                            }
                        }
                        /* tableRes.Table.forEach {
                             pcsTotal += it.PCS!!
                             mtrsTotal += it.MTRS!!
                         }*/
                        // Log.e("pcsTotal",pcsTotal.toString())
                        // Log.e("mtrsTotal",mtrsTotal.toString())


                        try {
                            createPDF(result)
                        } catch (e: FileNotFoundException) {
                            result.success("no url");
                            e.printStackTrace()
                        } catch (e: DocumentException) {
                            result.success("no url");
                            e.printStackTrace()
                        }
                    } catch (e: Exception) {
                        result.success("no url");
                        e.printStackTrace()
                    }

                }
                "getGeneratedLedgerPdfLocation" -> {


                    try {
                        val haspMAP = (call.arguments as HashMap<*, *>)

                        val jsonData = haspMAP["pdf_data"].toString()

                        val comDetail = haspMAP["company_detail"].toString()
                        party_name = haspMAP["party_name"].toString()
                        pdfDate = haspMAP["pdf_date"].toString()


                        Log.e("pdf Data", jsonData)
                        ledgerRes = Gson().fromJson(jsonData, LedgerRes::class.java)
                        companyDetail = Gson().fromJson(comDetail, CompanyDetail::class.java)

                        // var otherItemSize = tableRes.Table1.size

                        /*  if(tableRes.Table1.size>0){
                              tableRes.Table1.forEach {

                                  var table=Table()
                                  table.ITEMNAME=""
                                  table.DESIGNNO=""
                                  table.COLOR=""
                                  table.UNIT=""
                                  table.GODOWN=""
                                  table.PCS=it.PCS
                                  table.MTRS=it.MTRS
                                  table.ITEMID=0.0
                                  table.DESIGNID=0.0
                                  table.COLORID=0.0


                                  pcsTotal += it.PCS!!
                                  mtrsTotal += it.MTRS!!

                              }
                          }*/



                        try {
                            createLedgerPDF(result)
                        } catch (e: FileNotFoundException) {
                            result.success("no url");
                            e.printStackTrace()
                        } catch (e: DocumentException) {
                            result.success("no url");
                            e.printStackTrace()
                        }
                    } catch (e: Exception) {
                        result.success("no url");
                        e.printStackTrace()
                    }

                }
                else -> {
                    result.success("no url");
                }
            }
        }
    }


    @SuppressLint("SuspiciousIndentation")
    @Throws(FileNotFoundException::class, DocumentException::class)
    fun createPDF(result: MethodChannel.Result) {

        //Create document file
        val document = Document()
        try {
            val dateFormat = SimpleDateFormat("ddMMyyyy_HHmm")

            val sdf = SimpleDateFormat("dd-M-yyyy ")
            val currentDate = sdf.format(Date())


            val mydir =
                context.getDir("mydir", Context.MODE_PRIVATE) //Creating an internal directory;
            val fileName = "texTrade" + System.currentTimeMillis() + ".pdf"
            val fileWithinMyDir = File(mydir, fileName)
            fileWithinMyDir.createNewFile()
            val outputStream = FileOutputStream(
                File(
                    fileWithinMyDir.parent,
                    fileName
                )
            )
            val writer = PdfWriter.getInstance(document, outputStream)

            val event = HeaderFooterPageEvent()
            writer.pageEvent = event
            document.open()
            document.pageSize = PageSize.A4
            document.addCreationDate()

            addHeader(document, companyDetail.CMPNAME, true)
            addHeader(document, "", true)
            addHeader(document, companyDetail.ADD1, true)
            addHeader(document, companyDetail.ADD2, true)
            // addHeader(document,"",true)
            addHeader(document, "Stock Report", true)
            addHeader(document, pdfDate, true)
            addHeader(document, "Print Date : $currentDate", false)
            addHeader(document, "", false)
            addHeader(document, "", false)
            cell = PdfPCell()
            cell.border = Rectangle.NO_BORDER


            try {
                val table = PdfPTable(6)
                //table.widthPercentage = 100f

                val columnWidths = floatArrayOf(15f, 30f, 30f, 20f,15f,15f)
                table.setWidths(columnWidths)
                cell = PdfPCell()
                cell.backgroundColor = headColor
                cell.colspan = 30

                table.addCell(cell)

                cell = PdfPCell()
                cell.colspan = 30
                cell.backgroundColor = tableHeadColor
                val bf = BaseFont.createFont(
                    BaseFont.TIMES_ROMAN,
                    BaseFont.CP1252,
                    BaseFont.EMBEDDED
                )

                val font = Font(bf, 8f)

                //  cell = PdfPCell(Phrase("PIECETYPE", font))

                //  table.addCell(cell)
                cell = PdfPCell(Phrase("ITEMNAME", font))

                table.addCell(cell)
                cell = PdfPCell(Phrase("DESIGNNO", font))

                table.addCell(cell)
                cell = PdfPCell(Phrase("COLOR", font))

                table.addCell(cell)
                cell = PdfPCell(Phrase("UNIT", font))

                table.addCell(cell)
//                cell = PdfPCell(Phrase("GODOWN", font))

//                table.addCell(cell)
                cell = PdfPCell(Phrase("PCS", font))

                table.addCell(cell)
                cell = PdfPCell(Phrase("MTRS", font))

                table.addCell(cell)
//                cell = PdfPCell(Phrase("ITEMID", font))
//
//                table.addCell(cell)
//                cell = PdfPCell(Phrase("DESIGNID", font))
//
//                table.addCell(cell)
//                cell = PdfPCell(Phrase("COLORID", font))
//
//                table.addCell(cell)

                cell = PdfPCell()
                cell.colspan = 30

                tableRes.Table.forEach {
                    //  table.addCell(PdfPCell(Phrase(it.PIECETYPE, font)))
                    //table.addCell(it.PIECETYPE)
                    table.addCell(PdfPCell(Phrase(it.ITEMNAME, font)))
                    table.addCell(PdfPCell(Phrase(it.DESIGNNO, font)))
                    table.addCell(PdfPCell(Phrase(it.COLOR, font)))
                    table.addCell(PdfPCell(Phrase(it.UNIT, font)))
                    // table.addCell(PdfPCell(Phrase(it.GODOWN, font)))
                    var pcell =  PdfPCell()
                    var p =  Paragraph(it.PCS?.let { it1 -> roundOffDecimal(it1).toString() })
                    p.font=font
                    p.alignment = Element.ALIGN_RIGHT
                    pcell.addElement(p);
                    pcell.horizontalAlignment = Element.ALIGN_CENTER;
                    var pcell1 =  PdfPCell()

                    var p1 =  Paragraph(it.MTRS?.let { it1 -> roundOffDecimal(it1).toString() })
                    p1.font=font
                    p1.alignment = Element.ALIGN_RIGHT;
                    pcell1.addElement(p1);
                    pcell1.horizontalAlignment = Element.ALIGN_CENTER;
                    table.addCell(pcell)

                    table.addCell(pcell1)
                    // table.addCell(PdfPCell(Phrase(it.ITEMID.toString(), font)))
                    // table.addCell(PdfPCell(Phrase(it.DESIGNID.toString(), font)))
                    // table.addCell(PdfPCell(Phrase(it.COLORID.toString(), font)))

                }
                table.addCell(PdfPCell(Phrase("", font)))
                table.addCell(PdfPCell(Phrase("", font)))
                table.addCell(PdfPCell(Phrase("", font)))
                table.addCell(PdfPCell(Phrase("Total", font)))
                pcsTotal = roundOffDecimal(pcsTotal)
                mtrsTotal = roundOffDecimal(mtrsTotal)

                var pcell =  PdfPCell()
                var p =  Paragraph(pcsTotal.toString())
                p.font=font
                p.alignment = Element.ALIGN_RIGHT;
                pcell.addElement(p);
                var pcell1 =  PdfPCell()
                var p1 =  Paragraph(pcsTotal.toString())
                p1.font=font
                p1.alignment = Element.ALIGN_RIGHT;
                pcell1.addElement(p1);
                table.addCell(pcell)

                table.addCell(pcell1)
                //table.addCell(PdfPCell(Phrase("$pcsTotal", font)))
               // table.addCell(PdfPCell(Phrase("$mtrsTotal", font)))

                table.addCell(cell)

                document.add(table)
                addHeader(document, "", false)
                addHeader(document, "", false)
                addHeader(document, "", false)
                addHeader(document, "", false)
                addHeader(document, "", false)
                addHeader(document, "", false)
                addHeader(document, "Sent Throught :- Textrade App", false)
                addHeader(document, "Powered by :- Nakoda Infotech", false)

                Toast.makeText(
                    applicationContext,
                    "New File created successfully",
                    Toast.LENGTH_LONG
                ).show()

                result.success(fileWithinMyDir.absolutePath)
            } catch (de: DocumentException) {
                Log.e("PDFCreator", "DocumentException:$de")
            } catch (e: IOException) {
                Log.e("PDFCreator", "ioException:$e")
            } finally {
                document.close()
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    @SuppressLint("SuspiciousIndentation")
    @Throws(FileNotFoundException::class, DocumentException::class)
    fun createLedgerPDF(result: MethodChannel.Result) {

        //Create document file
        val document = Document()
        try {
            val dateFormat = SimpleDateFormat("ddMMyyyy_HHmm")

            val sdf = SimpleDateFormat("dd-M-yyyy ")
            val currentDate = sdf.format(Date())


            val mydir =
                context.getDir("mydir", Context.MODE_PRIVATE) //Creating an internal directory;
            val fileName = "texTrade" + System.currentTimeMillis() + ".pdf"
            val fileWithinMyDir = File(mydir, fileName)
            fileWithinMyDir.createNewFile()
            val outputStream = FileOutputStream(
                File(
                    fileWithinMyDir.parent,
                    fileName
                )
            )
            val writer = PdfWriter.getInstance(document, outputStream)

            val event = HeaderFooterPageEvent()
            writer.pageEvent = event
            document.open()
            document.pageSize = PageSize.A4
            document.addCreationDate()

            addHeader(document, companyDetail.CMPNAME, true)
            addHeader(document, "", true)
            addHeader(document, companyDetail.ADD1, true)
            addHeader(document, companyDetail.ADD2, true)
            // addHeader(document,"",true)
            addHeader(document, "$party_name (Ledger Report)", true)
            addHeader(document, pdfDate, true)
            addHeader(document, "Print Date : $currentDate", false)
            addHeader(document, "", false)
            addHeader(document, "", false)
            cell = PdfPCell()
            cell.border = Rectangle.NO_BORDER


            try {
                val table = PdfPTable(6)
                //table.widthPercentage = 100f
                val columnWidths = floatArrayOf(10f, 10f, 10f, 30f,10f,10f)
                table.setWidths(columnWidths)
                cell = PdfPCell()
                cell.backgroundColor = headColor
                cell.colspan = 30

                table.addCell(cell)

                cell = PdfPCell()
                cell.colspan = 30
                cell.backgroundColor = tableHeadColor
                val bf = BaseFont.createFont(
                    BaseFont.TIMES_ROMAN,
                    BaseFont.CP1252,
                    BaseFont.EMBEDDED
                )

                val font = Font(bf, 8f)

                //  cell = PdfPCell(Phrase("PIECETYPE", font))

                //  table.addCell(cell)

                cell = PdfPCell(Phrase(" Date", font))

                table.addCell(cell)
                cell = PdfPCell(Phrase(" ACCTYPE", font))

                table.addCell(cell)
                cell = PdfPCell(Phrase(" BILLNO", font))

                table.addCell(cell)
                cell = PdfPCell(Phrase(" DESC", font))

                table.addCell(cell)
//                cell = PdfPCell(Phrase("GODOWN", font))

//                table.addCell(cell)
                cell = PdfPCell(Phrase(" AMT", font))

                table.addCell(cell)
                cell = PdfPCell(Phrase(" DRCR", font))

                table.addCell(cell)
//                cell = PdfPCell(Phrase("ITEMID", font))
//
//                table.addCell(cell)
//                cell = PdfPCell(Phrase("DESIGNID", font))
//
//                table.addCell(cell)
//                cell = PdfPCell(Phrase("COLORID", font))
//
//                table.addCell(cell)

                cell = PdfPCell()
                cell.colspan = 30

                val pcell = PdfPCell()

                ledgerRes.Table1.forEach {
                    //  table.addCell(PdfPCell(Phrase(it.PIECETYPE, font)))
                    //table.addCell(it.PIECETYPE)
                    //2022-04-01T00:00:00
                    val parser = SimpleDateFormat("yyy-MM-dd'T'HH:mm:ss", Locale.getDefault())
                    val formatter = SimpleDateFormat("dd-MM-yyyy", Locale.getDefault())
                    val formattedDate = it.DATE?.let { it1 ->
                        parser.parse(it1)?.let { it1 -> formatter.format(it1) }
                    }
                    table.addCell(PdfPCell(Phrase(formattedDate, font)))
                    table.addCell(PdfPCell(Phrase(" ${it.ACCTYPE}", font)))
                    table.addCell(PdfPCell(Phrase(" ${it.BILLNO}", font)))
                    table.addCell(PdfPCell(Phrase(" ${it.DESC}", font)))
                    // table.addCell(PdfPCell(Phrase(it.GODOWN, font)))

                   var pcell =  PdfPCell()
                    var p =  Paragraph(it.AMT?.let { it1 -> " ${roundOffDecimal(it1)}" })
                    p.font=font
                    p.alignment = Element.ALIGN_RIGHT
                    pcell.addElement(p);
                   // pcell.paddingBottom=10f
                    table.addCell(pcell)
                   /* table.addCell(
                        PdfPCell(
                            Phrase(
                                it.AMT?.let { it1 -> roundOffDecimal(it1.toDouble()).toString() },
                                font
                            )
                        )
                    )*/
                    table.addCell(PdfPCell(Phrase(" ${it.DRCR.toString()}", font)))
                    // table.addCell(PdfPCell(Phrase(it.ITEMID.toString(), font)))
                    // table.addCell(PdfPCell(Phrase(it.DESIGNID.toString(), font)))
                    // table.addCell(PdfPCell(Phrase(it.COLORID.toString(), font)))

                }
                /* table.addCell(PdfPCell(Phrase("", font)))
                 table.addCell(PdfPCell(Phrase("", font)))
                 table.addCell(PdfPCell(Phrase("", font)))
                 table.addCell(PdfPCell(Phrase("Total", font)))
                 pcsTotal=roundOffDecimal(pcsTotal)
                 mtrsTotal=roundOffDecimal(mtrsTotal)
                 table.addCell(PdfPCell(Phrase("$pcsTotal", font)))
                 table.addCell(PdfPCell(Phrase("$mtrsTotal", font)))

                 table.addCell(cell)*/

                document.add(table)
                addHeader(document, "", false)
                addHeader(document, "", false)
                addHeader(document, "", false)
                addHeader(document, "", false)
                addHeader(document, "", false)
                addHeader(document, "", false)
                addHeader(document, "Sent Throught :- Textrade App", false)
                addHeader(document, "Powered by :- Nakoda Infotech", false)

                Toast.makeText(
                    applicationContext,
                    "New File created successfully",
                    Toast.LENGTH_LONG
                ).show()

                result.success(fileWithinMyDir.absolutePath)
            } catch (de: DocumentException) {
                Log.e("PDFCreator", "DocumentException:$de")
            } catch (e: IOException) {
                Log.e("PDFCreator", "ioException:$e")
            } finally {
                document.close()
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    fun roundOffDecimal(number: Double): Double {
        val df = DecimalFormat("#.##")
        df.roundingMode = RoundingMode.CEILING
        return df.format(number).toDouble()
    }

    private fun addHeader(document: Document, text: String, isHorizontal: Boolean) {
        val bf = BaseFont.createFont(
            BaseFont.TIMES_ROMAN,
            BaseFont.CP1252,
            BaseFont.EMBEDDED
        )

        val headerFont = Font(bf, 8f)

        val headerTable = PdfPTable(1)

        headerTable.defaultCell.fixedHeight = 40f
        headerTable.widthPercentage = 100f
        var headerCell = PdfPCell(Phrase(text, headerFont))
        headerCell.border = Rectangle.NO_BORDER
        headerCell.borderColor = BaseColor.WHITE
        if (isHorizontal)
            headerCell.horizontalAlignment = Element.ALIGN_CENTER

        headerTable.addCell(headerCell)
        document.add(headerTable)

    }


    //Check READ/WRITE PERMISSION
    private fun checkPermission(): Boolean {
        return (ContextCompat.checkSelfPermission(
            this,
            Manifest.permission.WRITE_EXTERNAL_STORAGE
        ) != PackageManager.PERMISSION_GRANTED
                && ContextCompat.checkSelfPermission(
            this,
            Manifest.permission.READ_EXTERNAL_STORAGE
        ) != PackageManager.PERMISSION_GRANTED)
    }
}
