package com.example.textrade

import com.itextpdf.text.*
import com.itextpdf.text.pdf.*
import java.io.IOException
import java.net.MalformedURLException

class HeaderFooterPageEvent : PdfPageEventHelper() {
    private var t: PdfTemplate? = null
    private var total: Image? = null
    override fun onOpenDocument(writer: PdfWriter, document: Document) {
        t = writer.directContent.createTemplate(30f, 16f)
        try {
            total = Image.getInstance(t)
            total?.role = PdfName.ARTIFACT
        } catch (de: DocumentException) {
            throw ExceptionConverter(de)
        }
    }

    override fun onEndPage(writer: PdfWriter, document: Document) {
        // addHeader(writer);
        addFooter(writer)
    }

    private fun addHeader(writer: PdfWriter) {
        val header = PdfPTable(2)
        try {
            // set defaults
            header.setWidths(intArrayOf(2, 24))
            header.totalWidth = 527f
            header.isLockedWidth = true
            header.defaultCell.fixedHeight = 100f
            header.defaultCell.border = Rectangle.BOTTOM
            header.defaultCell.borderColor = BaseColor.LIGHT_GRAY

            // add image
            val logo = Image.getInstance(
                HeaderFooterPageEvent::class.java.getResource("/memorynotfound-logo.jpg")
            )
            header.addCell(logo)

            // add text
            val text = PdfPCell()
            text.paddingBottom = 15f
            text.paddingTop = 105f
            text.paddingLeft = 10f
            text.border = Rectangle.BOTTOM
            text.borderColor = BaseColor.LIGHT_GRAY
            text.addElement(
                Phrase(
                    "iText PDF Header Footer Example",
                    Font(Font.FontFamily.HELVETICA, 12f)
                )
            )
            text.addElement(
                Phrase(
                    "https://memorynotfound.com",
                    Font(Font.FontFamily.HELVETICA, 8f)
                )
            )
            header.addCell(text)

            // write content
            header.writeSelectedRows(0, -1, 34f, 803f, writer.directContent)
        } catch (de: DocumentException) {
            throw ExceptionConverter(de)
        } catch (e: MalformedURLException) {
            throw ExceptionConverter(e)
        } catch (e: IOException) {
            throw ExceptionConverter(e)
        }
    }

    private fun addFooter(writer: PdfWriter) {
        val footer = PdfPTable(3)
        try {
            // set defaults
            footer.setWidths(intArrayOf(24, 2, 1))
            footer.totalWidth = 527f
            footer.isLockedWidth = true
            footer.defaultCell.fixedHeight = 40f
            footer.defaultCell.border = Rectangle.TOP
            footer.defaultCell.borderColor = BaseColor.WHITE

            // add copyright
            footer.defaultCell.horizontalAlignment = Element.ALIGN_CENTER
            footer.addCell(
                Phrase(
                    "Created by Nakoda infotech",
                    Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL)
                )
            )

            // add current page count
            // footer.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
            footer.addCell(Phrase(""))

            // add placeholder for total page count
            val totalPageCount = PdfPCell(total)
            totalPageCount.border = Rectangle.TOP
            totalPageCount.borderColor = BaseColor.WHITE
            footer.addCell(Phrase("", Font(Font.FontFamily.HELVETICA, 8f, Font.NORMAL)))

            // write page
            val canvas = writer.directContent
            canvas.beginMarkedContentSequence(PdfName.ARTIFACT)
            footer.writeSelectedRows(0, -1, 34f, 20f, canvas)
            canvas.endMarkedContentSequence()
        } catch (de: DocumentException) {
            throw ExceptionConverter(de)
        }
    }

    override fun onCloseDocument(writer: PdfWriter, document: Document) {
        val totalLength = writer.pageNumber.toString().length
        val totalWidth = totalLength * 5
        ColumnText.showTextAligned(
            t, Element.ALIGN_RIGHT,
            Phrase(writer.pageNumber.toString(), Font(Font.FontFamily.HELVETICA, 8f)),
            totalWidth.toFloat(), 6f, 0f
        )
    }
}