
[Forma]
Clave=eDocDocumento
Icono=0
Modulos=(Todos)
Nombre=Documento Electrónico

ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Modulo,Info.Descripcion)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=273
PosicionInicialArriba=116
PosicionInicialAlturaCliente=470
PosicionInicialAncho=733
[Ficha]
Estilo=Ficha
Clave=Ficha
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocDocumento
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
ListaEnCaptura=eDocDocumento.Documento
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
AlinearTodaCarpeta=S

FiltroGeneral=eDocDocumento.Modulo = {Comillas(Info.Modulo)} AND eDocDocumento.eDoc = {Comillas(Info.Descripcion)}
[Ficha.eDocDocumento.Documento]
Carpeta=Ficha
Clave=eDocDocumento.Documento
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
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

GuardarAntes=S
[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreDesplegar=&Cancelar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S














[Acciones.Ayuda]
Nombre=Ayuda
Boton=101
NombreEnBoton=S
NombreDesplegar=&Ayuda Plantillas
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S



Expresion=Asigna(Temp.Modulo,Info.Modulo)<BR>Asigna(Temp.Personal,Info.Vista)<BR>Asigna(Info.Modulo,<T>Todos<T>)<BR>Asigna(Info.Vista,<T>Plantilla<T>)<BR>Asigna(Info.Campo,NULO)<BR>FormaModal(<T>eDocModuloVistaAyuda<T>)<BR>Asigna(Info.Modulo,Temp.Modulo)<BR>Asigna(Info.Vista,Temp.Personal)

[Lista.Columnas]
0=165
1=538







[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Ayuda
Ayuda=(Fin)
