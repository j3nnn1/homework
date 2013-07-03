
shinyUI(
   pageWithSidebar( 
   headerPanel("Desocupación y Empleo 2003 - 2010"),
   sidebarPanel(
       selectInput("dataset", 
           "Provincia:",

           choices = c(#"Bahia Blanca", 
		"Ciudad de Buenos Aires",
		"Corrientes", 
		"Cordoba",
		"Formosa",
		"Catamarca",
		"Mendoza",
		"Rosario",
		"San Juan",
		"Santa Fe",
		"Tucuman",
		"Jujuy",
		"Rioja",
		"Neuquen",
		"Entre Rios",
		"Bs As",
		"Chubut",
		"Chaco",
		"Misiones",
		"San Luis",
		"Salta",
		"Santiago",
		"Santa Cruz",
		"La Pampa",
		"Tierra Fuego",
		"Rio Negro"
		))
   ),
   mainPanel (
       htmlOutput("desPlot")
   )
))
