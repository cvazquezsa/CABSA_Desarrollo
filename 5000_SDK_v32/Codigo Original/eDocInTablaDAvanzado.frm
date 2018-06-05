
[Forma]
Clave=eDocInTablaDAvanzado
Icono=0
CarpetaPrincipal=eDocInRutaTablaDAvanzado
Modulos=(Todos)
Nombre=Avanzado

ListaCarpetas=eDocInRutaTablaDAvanzado
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=371
PosicionInicialArriba=216
PosicionInicialAlturaCliente=389
PosicionInicialAncho=858
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Descripcion,Info.Ruta,Info.Tabla,Info.Campo)





[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=21
NombreEnBoton=S
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S








[eDocInRutaTablaD.ListaEnCaptura]
(Inicio)=eDocInRutaTablaD.CampoXMLRuta
eDocInRutaTablaD.CampoXMLRuta=eDocInRutaTablaD.CampoXMLAtributo
eDocInRutaTablaD.CampoXMLAtributo=eDocInRutaTablaD.CampoXMLTipoXML
eDocInRutaTablaD.CampoXMLTipoXML=eDocInRutaTablaD.ExpresionXML
eDocInRutaTablaD.ExpresionXML=(Fin)








[eDocInRutaTablaDAvanzado]
Estilo=Ficha
Clave=eDocInRutaTablaDAvanzado
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocInRutaTablaDAvanzado
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
ListaEnCaptura=(Lista)

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=eDocInRutaTablaDAvanzado.eDocIn = <T>{Info.Descripcion}<T> AND<BR>eDocInRutaTablaDAvanzado.Ruta = <T>{Info.Ruta}<T> AND<BR>eDocInRutaTablaDAvanzado.Tablas = <T>{Info.Tabla}<T> AND<BR>eDocInRutaTablaDAvanzado.RID = {Info.RID}
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
[eDocInRutaTablaDAvanzado.ListaEnCaptura]
(Inicio)=eDocInRutaTablaDAvanzado.CampoXMLRuta
eDocInRutaTablaDAvanzado.CampoXMLRuta=eDocInRutaTablaDAvanzado.CampoXMLAtributo
eDocInRutaTablaDAvanzado.CampoXMLAtributo=eDocInRutaTablaDAvanzado.CampoXMLTipoXML
eDocInRutaTablaDAvanzado.CampoXMLTipoXML=eDocInRutaTablaDAvanzado.ExpresionXML
eDocInRutaTablaDAvanzado.ExpresionXML=(Fin)

[eDocInRutaTablaDAvanzado.eDocInRutaTablaDAvanzado.CampoXMLRuta]
Carpeta=eDocInRutaTablaDAvanzado
Clave=eDocInRutaTablaDAvanzado.CampoXMLRuta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[eDocInRutaTablaDAvanzado.eDocInRutaTablaDAvanzado.CampoXMLAtributo]
Carpeta=eDocInRutaTablaDAvanzado
Clave=eDocInRutaTablaDAvanzado.CampoXMLAtributo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[eDocInRutaTablaDAvanzado.eDocInRutaTablaDAvanzado.CampoXMLTipoXML]
Carpeta=eDocInRutaTablaDAvanzado
Clave=eDocInRutaTablaDAvanzado.CampoXMLTipoXML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[eDocInRutaTablaDAvanzado.eDocInRutaTablaDAvanzado.ExpresionXML]
Carpeta=eDocInRutaTablaDAvanzado
Clave=eDocInRutaTablaDAvanzado.ExpresionXML
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
