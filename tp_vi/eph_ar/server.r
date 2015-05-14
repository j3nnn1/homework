library(googleVis)
library(shiny)

arg.empleo.ciudadbsas <- read.table("eph_ciudadBuenosAires.csv", sep=";", header=T)
arg.empleo.bahia <- read.table("eph_bahiablanca.csv", sep=";", header=T)
arg.empleo.corrientes <- read.table("eph_corrientes.csv", sep=";", header=T)
arg.empleo.cordoba <- read.table("eph_cordoba.csv", sep=";", header=T)
arg.empleo.formosa <- read.table("eph_Formosa.csv", sep=";", header=T)
arg.empleo.catamarca <- read.table("eph_catamarca.csv", sep=";", header=T)
arg.empleo.mendoza <- read.table("eph_mendoza.csv", sep=";", header=T)
arg.empleo.rosario <- read.table("eph_rosario.csv", sep=";", header=T)
arg.empleo.sanjuan <- read.table("eph_sanjuan.csv", sep=";", header=T)
arg.empleo.santafe <- read.table("eph_santafe.csv", sep=";", header=T)
arg.empleo.tucuman <- read.table("eph_tucuman.csv", sep=";", header=T)
arg.empleo.jujuy <- read.table("eph_jujuy.csv", sep=";", header=T)
arg.empleo.rioja <- read.table("eph_rioja.csv", sep=";", header=T)
arg.empleo.neuquen <- read.table("eph_neuquen.csv", sep=";", header=T)
arg.empleo.entrerios <- read.table("eph_entrerios.csv", sep=";", header=T)
arg.empleo.bsas <- read.table("eph_partidosBuenosAires.csv", sep=";", header=T)
arg.empleo.chubut <- read.table("eph_chubut.csv", sep=";", header=T)
arg.empleo.chaco <- read.table("eph_chaco.csv", sep=";", header=T)
arg.empleo.mision <- read.table("eph_misiones.csv", sep=";", header=T)
arg.empleo.sanluis <- read.table("eph_sanluis.csv", sep=";", header=T)
arg.empleo.salta <- read.table("eph_salta.csv", sep=";", header=T)
arg.empleo.santiago <- read.table("eph_santiago.csv", sep=";", header=T)
arg.empleo.santacruz <- read.table("eph_santacruz.csv", sep=";", header=T)
arg.empleo.lapampa <- read.table("eph_lapampa.csv", sep=";", header=T)
arg.empleo.tierrafuego <- read.table("eph_tierrafuego.csv", sep=";", header=T)
arg.empleo.rionegro <- read.table("eph_rionegro.csv", sep=";", header=T)

arg.empleo.ciudadbsas$Desocupacion = as.numeric(arg.empleo.ciudadbsas$Desocupacion)
arg.empleo.ciudadbsas$Actividad = as.numeric(arg.empleo.ciudadbsas$Actividad)
arg.empleo.ciudadbsas$subocupacion_no_demandante = as.numeric(arg.empleo.ciudadbsas$subocupacion_no_demandante)
arg.empleo.ciudadbsas$empleo = as.numeric(arg.empleo.ciudadbsas$empleo)
arg.empleo.ciudadbsas$subocupacion_demandante = as.numeric(arg.empleo.ciudadbsas$subocupacion_demandante)

arg.empleo.bahia$Desocupacion = as.numeric(arg.empleo.bahia$Desocupacion)
arg.empleo.bahia$Actividad = as.numeric(arg.empleo.bahia$Actividad)
arg.empleo.bahia$subocupacion_no_demandante = as.numeric(arg.empleo.bahia$subocupacion_no_demandante)
arg.empleo.bahia$empleo = as.numeric(arg.empleo.bahia$empleo)
arg.empleo.bahia$subocupacion_demandante = as.numeric(arg.empleo.bahia$subocupacion_demandante)

arg.empleo.corrientes$Desocupacion = as.numeric(arg.empleo.corrientes$Desocupacion)
arg.empleo.corrientes$Actividad = as.numeric(arg.empleo.corrientes$Actividad)
arg.empleo.corrientes$subocupacion_no_demandante = as.numeric(arg.empleo.corrientes$subocupacion_no_demandante)
arg.empleo.corrientes$empleo = as.numeric(arg.empleo.corrientes$empleo)
arg.empleo.corrientes$subocupacion_demandante = as.numeric(arg.empleo.corrientes$subocupacion_demandante)

arg.empleo.cordoba$Desocupacion = as.numeric(arg.empleo.cordoba$Desocupacion)
arg.empleo.cordoba$Actividad = as.numeric(arg.empleo.cordoba$Actividad)
arg.empleo.cordoba$subocupacion_no_demandante = as.numeric(arg.empleo.cordoba$subocupacion_no_demandante)
arg.empleo.cordoba$empleo = as.numeric(arg.empleo.cordoba$empleo)
arg.empleo.cordoba$subocupacion_demandante = as.numeric(arg.empleo.cordoba$subocupacion_demandante)

arg.empleo.formosa$Desocupacion = as.numeric(arg.empleo.formosa$Desocupacion)
arg.empleo.formosa$Actividad = as.numeric(arg.empleo.formosa$Actividad)
arg.empleo.formosa$subocupacion_no_demandante = as.numeric(arg.empleo.formosa$subocupacion_no_demandante)
arg.empleo.formosa$empleo = as.numeric(arg.empleo.formosa$empleo)
arg.empleo.formosa$subocupacion_demandante = as.numeric(arg.empleo.formosa$subocupacion_demandante)

arg.empleo.catamarca$Desocupacion = as.numeric(arg.empleo.catamarca$Desocupacion)
arg.empleo.catamarca$Actividad = as.numeric(arg.empleo.catamarca$Actividad)
arg.empleo.catamarca$subocupacion_no_demandante = as.numeric(arg.empleo.catamarca$subocupacion_no_demandante)
arg.empleo.catamarca$empleo = as.numeric(arg.empleo.catamarca$empleo)
arg.empleo.catamarca$subocupacion_demandante = as.numeric(arg.empleo.catamarca$subocupacion_demandante)

arg.empleo.mendoza$Desocupacion = as.numeric(arg.empleo.mendoza$Desocupacion)
arg.empleo.mendoza$Actividad = as.numeric(arg.empleo.mendoza$Actividad)
arg.empleo.mendoza$subocupacion_no_demandante = as.numeric(arg.empleo.mendoza$subocupacion_no_demandante)
arg.empleo.mendoza$empleo = as.numeric(arg.empleo.mendoza$empleo)
arg.empleo.mendoza$subocupacion_demandante = as.numeric(arg.empleo.mendoza$subocupacion_demandante)

arg.empleo.rosario$Desocupacion = as.numeric(arg.empleo.rosario$Desocupacion)
arg.empleo.rosario$Actividad = as.numeric(arg.empleo.rosario$Actividad)
arg.empleo.rosario$subocupacion_no_demandante = as.numeric(arg.empleo.rosario$subocupacion_no_demandante)
arg.empleo.rosario$empleo = as.numeric(arg.empleo.rosario$empleo)
arg.empleo.rosario$subocupacion_demandante = as.numeric(arg.empleo.rosario$subocupacion_demandante)

arg.empleo.sanjuan$Desocupacion = as.numeric(arg.empleo.sanjuan$Desocupacion)
arg.empleo.sanjuan$Actividad = as.numeric(arg.empleo.sanjuan$Actividad)
arg.empleo.sanjuan$subocupacion_no_demandante = as.numeric(arg.empleo.sanjuan$subocupacion_no_demandante)
arg.empleo.sanjuan$empleo = as.numeric(arg.empleo.sanjuan$empleo)
arg.empleo.sanjuan$subocupacion_demandante = as.numeric(arg.empleo.sanjuan$subocupacion_demandante)

arg.empleo.santafe$Desocupacion = as.numeric(arg.empleo.santafe$Desocupacion)
arg.empleo.santafe$Actividad = as.numeric(arg.empleo.santafe$Actividad)
arg.empleo.santafe$subocupacion_no_demandante = as.numeric(arg.empleo.santafe$subocupacion_no_demandante)
arg.empleo.santafe$empleo = as.numeric(arg.empleo.santafe$empleo)
arg.empleo.santafe$subocupacion_demandante = as.numeric(arg.empleo.santafe$subocupacion_demandante)

arg.empleo.tucuman$Desocupacion = as.numeric(arg.empleo.tucuman$Desocupacion)
arg.empleo.tucuman$Actividad = as.numeric(arg.empleo.tucuman$Actividad)
arg.empleo.tucuman$subocupacion_no_demandante = as.numeric(arg.empleo.tucuman$subocupacion_no_demandante)
arg.empleo.tucuman$empleo = as.numeric(arg.empleo.tucuman$empleo)
arg.empleo.tucuman$subocupacion_demandante = as.numeric(arg.empleo.tucuman$subocupacion_demandante)

arg.empleo.jujuy$Desocupacion = as.numeric(arg.empleo.jujuy$Desocupacion)
arg.empleo.jujuy$Actividad = as.numeric(arg.empleo.jujuy$Actividad)
arg.empleo.jujuy$subocupacion_no_demandante = as.numeric(arg.empleo.jujuy$subocupacion_no_demandante)
arg.empleo.jujuy$empleo = as.numeric(arg.empleo.jujuy$empleo)
arg.empleo.jujuy$subocupacion_demandante = as.numeric(arg.empleo.jujuy$subocupacion_demandante)

arg.empleo.rioja$Desocupacion = as.numeric(arg.empleo.rioja$Desocupacion)
arg.empleo.rioja$Actividad = as.numeric(arg.empleo.rioja$Actividad)
arg.empleo.rioja$subocupacion_no_demandante = as.numeric(arg.empleo.rioja$subocupacion_no_demandante)
arg.empleo.rioja$empleo = as.numeric(arg.empleo.rioja$empleo)
arg.empleo.rioja$subocupacion_demandante = as.numeric(arg.empleo.rioja$subocupacion_demandante)

arg.empleo.neuquen$Desocupacion = as.numeric(arg.empleo.neuquen$Desocupacion)
arg.empleo.neuquen$Actividad = as.numeric(arg.empleo.neuquen$Actividad)
arg.empleo.neuquen$subocupacion_no_demandante = as.numeric(arg.empleo.neuquen$subocupacion_no_demandante)
arg.empleo.neuquen$empleo = as.numeric(arg.empleo.neuquen$empleo)
arg.empleo.neuquen$subocupacion_demandante = as.numeric(arg.empleo.neuquen$subocupacion_demandante)

arg.empleo.entrerios$Desocupacion = as.numeric(arg.empleo.entrerios$Desocupacion)
arg.empleo.entrerios$Actividad = as.numeric(arg.empleo.entrerios$Actividad)
arg.empleo.entrerios$subocupacion_no_demandante = as.numeric(arg.empleo.entrerios$subocupacion_no_demandante)
arg.empleo.entrerios$empleo = as.numeric(arg.empleo.entrerios$empleo)
arg.empleo.entrerios$subocupacion_demandante = as.numeric(arg.empleo.entrerios$subocupacion_demandante)

arg.empleo.bsas$Desocupacion = as.numeric(arg.empleo.bsas$Desocupacion)
arg.empleo.bsas$Actividad = as.numeric(arg.empleo.bsas$Actividad)
arg.empleo.bsas$subocupacion_no_demandante = as.numeric(arg.empleo.bsas$subocupacion_no_demandante)
arg.empleo.bsas$empleo = as.numeric(arg.empleo.bsas$empleo)
arg.empleo.bsas$subocupacion_demandante = as.numeric(arg.empleo.bsas$subocupacion_demandante)

arg.empleo.chubut$Desocupacion = as.numeric(arg.empleo.chubut$Desocupacion)
arg.empleo.chubut$Actividad = as.numeric(arg.empleo.chubut$Actividad)
arg.empleo.chubut$subocupacion_no_demandante = as.numeric(arg.empleo.chubut$subocupacion_no_demandante)
arg.empleo.chubut$empleo = as.numeric(arg.empleo.chubut$empleo)
arg.empleo.chubut$subocupacion_demandante = as.numeric(arg.empleo.chubut$subocupacion_demandante)

arg.empleo.chaco$Desocupacion = as.numeric(arg.empleo.chaco$Desocupacion)
arg.empleo.chaco$Actividad = as.numeric(arg.empleo.chaco$Actividad)
arg.empleo.chaco$subocupacion_no_demandante = as.numeric(arg.empleo.chaco$subocupacion_no_demandante)
arg.empleo.chaco$empleo = as.numeric(arg.empleo.chaco$empleo)
arg.empleo.chaco$subocupacion_demandante = as.numeric(arg.empleo.chaco$subocupacion_demandante)

arg.empleo.mision$Desocupacion = as.numeric(arg.empleo.mision$Desocupacion)
arg.empleo.mision$Actividad = as.numeric(arg.empleo.mision$Actividad)
arg.empleo.mision$subocupacion_no_demandante = as.numeric(arg.empleo.mision$subocupacion_no_demandante)
arg.empleo.mision$empleo = as.numeric(arg.empleo.mision$empleo)
arg.empleo.mision$subocupacion_demandante = as.numeric(arg.empleo.mision$subocupacion_demandante)


arg.empleo.sanluis$Desocupacion = as.numeric(arg.empleo.sanluis$Desocupacion)
arg.empleo.sanluis$Actividad = as.numeric(arg.empleo.sanluis$Actividad)
arg.empleo.sanluis$subocupacion_no_demandante = as.numeric(arg.empleo.sanluis$subocupacion_no_demandante)
arg.empleo.sanluis$empleo = as.numeric(arg.empleo.sanluis$empleo)
arg.empleo.sanluis$subocupacion_demandante = as.numeric(arg.empleo.sanluis$subocupacion_demandante)

arg.empleo.salta$Desocupacion = as.numeric(arg.empleo.sanluis$Desocupacion)
arg.empleo.salta$Actividad = as.numeric(arg.empleo.sanluis$Actividad)
arg.empleo.salta$subocupacion_no_demandante = as.numeric(arg.empleo.sanluis$subocupacion_no_demandante)
arg.empleo.salta$empleo = as.numeric(arg.empleo.sanluis$empleo)
arg.empleo.salta$subocupacion_demandante = as.numeric(arg.empleo.sanluis$subocupacion_demandante)

arg.empleo.santiago$Desocupacion = as.numeric(arg.empleo.sanluis$Desocupacion)
arg.empleo.santiago$Actividad = as.numeric(arg.empleo.sanluis$Actividad)
arg.empleo.santiago$subocupacion_no_demandante = as.numeric(arg.empleo.sanluis$subocupacion_no_demandante)
arg.empleo.santiago$empleo = as.numeric(arg.empleo.sanluis$empleo)
arg.empleo.santiago$subocupacion_demandante = as.numeric(arg.empleo.sanluis$subocupacion_demandante)

arg.empleo.santacruz$Desocupacion = as.numeric(arg.empleo.santacruz$Desocupacion)
arg.empleo.santacruz$Actividad = as.numeric(arg.empleo.santacruz$Actividad)
arg.empleo.santacruz$subocupacion_no_demandante = as.numeric(arg.empleo.santacruz$subocupacion_no_demandante)
arg.empleo.santacruz$empleo = as.numeric(arg.empleo.santacruz$empleo)
arg.empleo.santacruz$subocupacion_demandante = as.numeric(arg.empleo.santacruz$subocupacion_demandante)

arg.empleo.tierrafuego$Desocupacion = as.numeric(arg.empleo.tierrafuego$Desocupacion)
arg.empleo.tierrafuego$Actividad = as.numeric(arg.empleo.tierrafuego$Actividad)
arg.empleo.tierrafuego$subocupacion_no_demandante = as.numeric(arg.empleo.tierrafuego$subocupacion_no_demandante)
arg.empleo.tierrafuego$empleo = as.numeric(arg.empleo.tierrafuego$empleo)
arg.empleo.tierrafuego$subocupacion_demandante = as.numeric(arg.empleo.tierrafuego$subocupacion_demandante)

arg.empleo.rionegro$Desocupacion = as.numeric(arg.empleo.rionegro$Desocupacion)
arg.empleo.rionegro$Actividad = as.numeric(arg.empleo.rionegro$Actividad)
arg.empleo.rionegro$subocupacion_no_demandante = as.numeric(arg.empleo.rionegro$subocupacion_no_demandante)
arg.empleo.rionegro$empleo = as.numeric(arg.empleo.rionegro$empleo)
arg.empleo.rionegro$subocupacion_demandante = as.numeric(arg.empleo.rionegro$subocupacion_demandante)


shinyServer(
   function (input, output) {

    datasetInput <- reactive({
    switch(input$dataset,
           #"Bahia Blanca" = arg.empleo.bahia,
           "Ciudad de Buenos Aires" = arg.empleo.ciudadbsas,
           "Corrientes" = arg.empleo.corrientes,
           "Cordoba" = arg.empleo.cordoba,
           "Formosa" = arg.empleo.formosa,
           "Catamarca" = arg.empleo.catamarca,
           "Mendoza" = arg.empleo.mendoza,
           "Rosario" = arg.empleo.rosario,
           "San Juan" = arg.empleo.sanjuan,
           "Santa Fe" = arg.empleo.santafe,
           "Tucuman" = arg.empleo.tucuman,
           "Jujuy" = arg.empleo.jujuy,
           "Rioja" = arg.empleo.rioja,
           "Neuquen" = arg.empleo.neuquen,
           "Entre Rios" = arg.empleo.entrerios,
           "Bs As" = arg.empleo.bsas,
           "Chubut" = arg.empleo.chubut,
           "Chaco" = arg.empleo.chaco,
           "Misiones" = arg.empleo.mision,
           "San Luis" = arg.empleo.sanluis,
           "Salta" = arg.empleo.salta,
           "Santiago" = arg.empleo.santiago,
           "Santa Cruz" = arg.empleo.santacruz,
           "La Pampa" = arg.empleo.lapampa,
           "Tierra Fuego" = arg.empleo.tierrafuego,
           "Rio Negro" = arg.empleo.rionegro
	  )
    })
  
    formulaText <- reactive({
       paste("Desocupacion ~", input$variable)
    })

    output$caption <- renderText({
       formulaText()
    })

    output$desPlot <- renderGvis({
       gvisScatterChart(datasetInput())
    })
   } 
)
