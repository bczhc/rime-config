#!/bin/env kscript

import java.io.File
import kotlin.streams.toList
import kotlin.system.exitProcess

if (args.isEmpty()) {
    println("Usage: Program <THUOCL-data> <out-dict>")
    exitProcess(0)
}

val thuoclData = args[0]
val outDict = args[1]
val dictId = Regex("^(.+)\\.dict\\.yaml$").findAll(outDict).toList()[0].groupValues[1]
println("DictId:$dictId")

data class Entry(
    val text: String,
    val freq: Int,
)

val existEntries = File("092wubi_ci.dict.yaml").readLines()
    .asSequence()
    .dropWhile { it != "..." }.drop(1)
    .filter { it.isNotEmpty() }.map { it.split("\t")[0] }.toHashSet()

val dictHeader = File("./dict_header").readText()

val file = File(thuoclData)
val entries = file.readLines().asSequence().filter { it.isNotEmpty() }.map {
    val split = it.split(Regex("\\s+"))
    try {
        return@map Entry(split[0], split.last().toInt())
    } catch (_: Exception) {
        println(it)
        return@map Entry(split[0], 0)
    }
}.sortedByDescending { it.freq }
    .filter { it.text.codePoints().count() >= 2L }
    .filter { !existEntries.contains(it.text) }.toList()

val charDictMap = hashMapOf<String, String>()

File("./092wubi_ci.dict.yaml").readLines()
    .dropWhile { it != "..." }.drop(1).filter { it.isNotEmpty() }.map {
        val split = it.split("\t")
        val word = split[0]
        val code = split[1]
        if (word.codePoints().count() == 1L) {
            if (charDictMap.contains(word) && code.length > charDictMap[word]!!.length) {
                charDictMap[word] = code
            }
            charDictMap[word] = code
        }
    }

charDictMap.values.forEach { myAssert(it.length >= 2) }

val output = File(outDict).bufferedWriter()

output.write(dictHeader.replace("\$NAME", dictId))

println("Entries: ${entries.size}")
entries.forEach {
    try {
        val composedCode = composeCode(it.text, charDictMap)
        output.appendLine("${it.text}\t$composedCode")
    } catch (_: Exception) {
        println("Failed to encode: $it")
    }
}
output.close()

fun composeCode(word: String, charMap: Map<String, String>): String {
    val wordChars = word.codePoints().toList().map { String(Character.toChars(it)) }
    val code = when (wordChars.size) {
        1 -> {
            throw RuntimeException("Unexpected length")
        }

        2 -> {
            charMap[wordChars[0]]!!.substring(0..1) + charMap[wordChars[1]]!!.substring(0..1)
        }

        3 -> {
            charMap[wordChars[0]]!![0].toString() + charMap[wordChars[1]]!![0] + charMap[wordChars[2]]!!.substring(0..1)
        }

        else -> {
            charMap[wordChars[0]]!![0].toString() + charMap[wordChars[1]]!![0] + charMap[wordChars[2]]!![0] + charMap[wordChars.last()]!![0]
        }
    }
    myAssert(code.length == 4)
    return code
}

fun myAssert(x: Boolean) {
    if (!x) {
        throw AssertionError()
    }
}
