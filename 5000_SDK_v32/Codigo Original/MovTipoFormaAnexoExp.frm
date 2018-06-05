[Forma]
Clave=MovTipoFormaAnexoExp
Nombre=Expresiones
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=AlAbrir
PosicionInicialIzquierda=588
PosicionInicialArriba=401
PosicionInicialAlturaCliente=370
PosicionInicialAncho=743
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaExclusiva=S
Comentarios=Info.Nombre

[AlAbrir]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=al Abrir
Clave=AlAbrir
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoFormaAnexoExp
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
ListaEnCaptura=MovTipoFormaAnexo.ExpresionesAlAbrir
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
FiltroGeneral=MovTipoFormaAnexo.Modulo=<T>{Info.Modulo}<T> AND<BR>MovTipoFormaAnexo.Mov=<T>{Info.Mov}<T> AND<BR>MovTipoFormaAnexo.Nombre=<T>{Info.Nombre}<T>

[AlAbrir.MovTipoFormaAnexo.ExpresionesAlAbrir]
Carpeta=AlAbrir
Clave=MovTipoFormaAnexo.ExpresionesAlAbrir
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
Tamano=100x20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[AlAnexar]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=al Anexar
Clave=AlAnexar
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoFormaAnexoExp
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
ListaEnCaptura=MovTipoFormaAnexo.ExpresionesAlAnexar
CarpetaVisible=S

[AlAnexar.MovTipoFormaAnexo.ExpresionesAlAnexar]
Carpeta=AlAnexar
Clave=MovTipoFormaAnexo.ExpresionesAlAnexar
Editar=S
LineaNueva=S
3D=S
Tamano=100x20
ColorFondo=Blanco
ColorFuente=Negro

[AlEliminar]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=al Eliminar
Clave=AlEliminar
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoFormaAnexoExp
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
ListaEnCaptura=MovTipoFormaAnexo.ExpresionesAlEliminar
CarpetaVisible=S

[AlEliminar.MovTipoFormaAnexo.ExpresionesAlEliminar]
Carpeta=AlEliminar
Clave=MovTipoFormaAnexo.ExpresionesAlEliminar
Editar=S
LineaNueva=S
3D=S
Tamano=100x20
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaCarpetas]
(Inicio)=AlAbrir
AlAbrir=AlAnexar
AlAnexar=AlEliminar
AlEliminar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)
