import socket from "./socket"
import { RacerController } from "./racer_controller"

export var MatchController = {

  validateKeyWord: ()=>{
    let lastWord = 0
    let textCurent = ""
    let nextWord = 0
    let score = 0
    let textArea = $("#textToValidate").text()
    $("#currentWord").text(textArea.charAt(nextWord))
    lastWord = textArea.length
    $("#pressKey").on("keydown", (event)=>{
      if (textArea.charAt(nextWord) === " "){
        console.log("Espacio")
        $("#currentWord").text("Espacio")
        $("#pressKey").val("")
      }
      else {
        $("#currentWord").text(textArea.charAt(nextWord))
      }
      console.log(`Presiona : ${event.key}, Numero de palabra: ${nextWord} , Letra del parrafo: ${textArea.charAt(nextWord)}`)
      if(event.key == textArea.charAt(nextWord)){
        textCurent +=textArea.charAt(nextWord)
        nextWord +=1
        score = (nextWord * 100) / (textArea.length)
        RacerController.sendScore(score)
        console.log(`Texto actual: ${textCurent} cadena:  ${textArea.substring(nextWord)}`)
        $("#textCurrent").text(textCurent)
        $("#textToValidate").text(textArea.substring(nextWord))
        $("#pressKey").removeClass("error")
      } else {
        $("#pressKey").addClass("error") 
      }
      console.log(event)
    })


  },
  bindEvents:function (){
    console.log("init envents from MatchControllet")
    this.validateKeyWord()
  
  },

  start: function(){
    this.bindEvents()
  }

}
