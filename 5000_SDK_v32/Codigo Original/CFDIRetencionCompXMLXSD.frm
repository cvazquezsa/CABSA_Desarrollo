

[Forma]
Clave=CFDIRetencionCompXMLXSD
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=CFDI Nómina - XSD Complemento
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Maximizado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Anuncio

ListaAcciones=(Lista)
PosicionInicialIzquierda=-8
PosicionInicialArriba=-8
PosicionInicialAlturaCliente=706
PosicionInicialAncho=1382
ListaCarpetas=Texto
CarpetaPrincipal=Texto
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Texto]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Texto
Clave=Texto
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetencionCompXMLXSD
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
ListaEnCaptura=CFDIRetencionCompXMLXSD.XSD
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
AlinearTodaCarpeta=S



FiltroGeneral=CFDIRetencionCompXMLXSD.Complemento = <T>{Info.Anuncio}<T>
[Texto.CFDIRetencionCompXMLXSD.XSD]
Carpeta=Texto
Clave=CFDIRetencionCompXMLXSD.XSD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ConScroll=S
SinRecapitular=S
Tamano=100x15
ColorFondo=Blanco

[Acciones.Registrar]
Nombre=Registrar
Boton=83
NombreDesplegar=Registrar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S















GuardarAntes=S
































Expresion=EJECUTARSQL(<T>EXEC spCFDIRetencionCompGenerarXMLSchema :tComplemento<T>, CFDIRetencionCompXMLXSD:CFDIRetencionCompXMLXSD.Complemento)


[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Registrar
Registrar=(Fin)
