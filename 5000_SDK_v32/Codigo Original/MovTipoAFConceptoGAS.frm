
[Forma]
Clave=MovTipoAFConceptoGAS
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Conceptos Gasto
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
PosicionInicialIzquierda=352
PosicionInicialArriba=150
PosicionInicialAlturaCliente=390
PosicionInicialAncho=661
ListaCarpetas=Lista
CarpetaPrincipal=Lista
Comentarios=Info.Mov
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

[Acciones.Cerrar]
Nombre=Cerrar
Boton=5
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S










[Lista]
Estilo=Hoja
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovTipoAFConceptoGAS
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S
Filtros=S

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=MovTipoAFConceptoGAS.Mov = <T>{Info.Mov}<T>
FiltroRespetar=S
FiltroTipo=General
[Lista.MovTipoAFConceptoGAS.Categoria]
Carpeta=Lista
Clave=MovTipoAFConceptoGAS.Categoria
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MovTipoAFConceptoGAS.Articulo]
Carpeta=Lista
Clave=MovTipoAFConceptoGAS.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MovTipoAFConceptoGAS.Serie]
Carpeta=Lista
Clave=MovTipoAFConceptoGAS.Serie
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MovTipoAFConceptoGAS.Concepto]
Carpeta=Lista
Clave=MovTipoAFConceptoGAS.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco


[Lista.Columnas]
Categoria=160
Articulo=111
Serie=101
Concepto=212








0=118
1=158
2=59
3=-2
[Lista.ListaEnCaptura]
(Inicio)=MovTipoAFConceptoGAS.Categoria
MovTipoAFConceptoGAS.Categoria=MovTipoAFConceptoGAS.Articulo
MovTipoAFConceptoGAS.Articulo=MovTipoAFConceptoGAS.Serie
MovTipoAFConceptoGAS.Serie=MovTipoAFConceptoGAS.Concepto
MovTipoAFConceptoGAS.Concepto=(Fin)



































[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=Cerrar
Cerrar=(Fin)
