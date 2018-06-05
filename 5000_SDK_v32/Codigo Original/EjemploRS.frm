[Forma]
Clave=EjemploRS
Icono=0
BarraHerramientas=S
Modulos=(Todos)
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=61
PosicionInicialAncho=233
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=523
PosicionInicialArriba=468
ListaCarpetas=(Variables)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Nombre=<T>Ejemplo Reporte<T>
VentanaExclusiva=S
VentanaEscCerrar=S
ExpresionesAlMostrar=Asigna(Info.MovID, <T>SO6952<T>)

[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=Info.MovID
CarpetaVisible=S

[(Variables).Info.MovID]
Carpeta=(Variables)
Clave=Info.MovID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Expresion.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Expresion.URL]
Nombre=URL
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=Cancelar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Browser(General.RSReportASPX+<T>ServerUrl=http%3a%2f%2fintmexs07%2fReportServer%3f%252fSampleReports%252fSales%2bOrder%2bDetail%26SalesOrderNumber%3d<T>+Info.MovID+<T>%26rc%253aParameters%3dFalse%26rc%253aReplacementRoot%3dhttp%253a%252f%252fintmexs07%252fReports%252fPages%252fReport.aspx%253fServerUrl%253d<T>, <T>Pedido <T>+Info.MovID)

[Forma.ListaAcciones]
(Inicio)=Preliminar
Preliminar=Cancelar
Cancelar=(Fin)
