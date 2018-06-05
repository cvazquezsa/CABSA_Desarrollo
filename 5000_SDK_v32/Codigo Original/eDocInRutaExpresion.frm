
[Forma]
Clave=eDocInRutaExpresion
Icono=0
CarpetaPrincipal=eDocInRutaExpresion
Modulos=(Todos)
Nombre=Expresión

ListaCarpetas=eDocInRutaExpresion
PosicionInicialAlturaCliente=161
PosicionInicialAncho=418
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=550
PosicionInicialArriba=208
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Aceptar
Comentarios=Lista(Info.Descripcion,Info.Ruta)
[eDocInRutaExpresion]
Estilo=Ficha
Clave=eDocInRutaExpresion
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=eDocInRutaExpresion
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
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
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

FiltroGeneral=eDocInRutaExpresion.eDocIn = <T>{Info.Descripcion}<T> AND<BR>eDocInRutaExpresion.Ruta = <T>{Info.Ruta}<T>
[eDocInRutaExpresion.eDocInRutaExpresion.SP]
Carpeta=eDocInRutaExpresion
Clave=eDocInRutaExpresion.SP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[eDocInRutaExpresion.eDocInRutaExpresion.Param1]
Carpeta=eDocInRutaExpresion
Clave=eDocInRutaExpresion.Param1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[eDocInRutaExpresion.eDocInRutaExpresion.Param2]
Carpeta=eDocInRutaExpresion
Clave=eDocInRutaExpresion.Param2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco




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

[eDocInRutaExpresion.ListaEnCaptura]
(Inicio)=eDocInRutaExpresion.SP
eDocInRutaExpresion.SP=eDocInRutaExpresion.Param1
eDocInRutaExpresion.Param1=eDocInRutaExpresion.Param2
eDocInRutaExpresion.Param2=(Fin)
