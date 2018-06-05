
[Forma]
Clave=eDocXSDDocumento
Icono=0
Modulos=(Todos)
Nombre=XSD

ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Modulo,Info.Clave)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=278
PosicionInicialArriba=108
PosicionInicialAlturaCliente=488
PosicionInicialAncho=723
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocXSDDocumento
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
ListaEnCaptura=eDocXSDDocumento.XSD
CarpetaVisible=S
AlinearTodaCarpeta=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=eDocXSDDocumento.Modulo = {Comillas(Info.Modulo)} AND eDocXSDDocumento.Clave = {Comillas(Info.Clave)}
[Ficha.eDocXSDDocumento.XSD]
Carpeta=Ficha
Clave=eDocXSDDocumento.XSD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

ConScroll=S
SinRecapitular=S
Tamano=100x15
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

[Acciones.Registrar]
Nombre=Registrar
Boton=83
NombreDesplegar=&Registrar
GuardarAntes=S
EnBarraHerramientas=S
BtnResaltado=S
EspacioPrevio=S
TipoAccion=Expresion
Expresion=EJECUTARSQL(<T>EXEC spCFDFlexGenerarXMLSchema :tModulo, :tClave<T>,eDocXSDDocumento:eDocXSDDocumento.Modulo,eDocXSDDocumento:eDocXSDDocumento.Clave)
Activo=S
Visible=S









[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Registrar
Registrar=(Fin)
