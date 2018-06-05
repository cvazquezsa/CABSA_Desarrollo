[Forma]
Clave=MovTipoFormaAnexo
Nombre=Formas Anexas
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=598
PosicionInicialArriba=405
PosicionInicialAlturaCliente=362
PosicionInicialAncho=724
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Info.Mov

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoFormaAnexo
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
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
HojaTitulos=S
HojaMostrarColumnas=S
FiltroGeneral=MovTipoFormaAnexo.Modulo=<T>{Info.Modulo}<T> AND<BR>MovTipoFormaAnexo.Mov=<T>{Info.Mov}<T>

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
Plantilla=339
Tipo=112
Clave=264
Nombre=318

[Lista.MovTipoFormaAnexo.Tipo]
Carpeta=Lista
Clave=MovTipoFormaAnexo.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoFormaAnexo.Clave]
Carpeta=Lista
Clave=MovTipoFormaAnexo.Clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Lista.MovTipoFormaAnexo.Nombre]
Carpeta=Lista
Clave=MovTipoFormaAnexo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Expresiones]
Nombre=Expresiones
Boton=47
NombreEnBoton=S
NombreDesplegar=&Expresiones
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MovTipoFormaAnexoExp
Visible=S
GuardarAntes=S
ConCondicion=S
Antes=S
Activo=S
EjecucionCondicion=ConDatos(MovTipoFormaAnexo:MovTipoFormaAnexo.Nombre)
AntesExpresiones=Asigna(Info.Nombre, MovTipoFormaAnexo:MovTipoFormaAnexo.Nombre)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Expresiones
Expresiones=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=MovTipoFormaAnexo.Tipo
MovTipoFormaAnexo.Tipo=MovTipoFormaAnexo.Clave
MovTipoFormaAnexo.Clave=MovTipoFormaAnexo.Nombre
MovTipoFormaAnexo.Nombre=(Fin)
