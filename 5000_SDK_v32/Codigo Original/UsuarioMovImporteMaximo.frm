[Forma]
Clave=UsuarioMovImporteMaximo
Nombre=Validación - Importe/Desc. Máximo
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Usuario
PosicionInicialAlturaCliente=300
PosicionInicialAncho=787
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=314
PosicionInicialArriba=345

VentanaEstadoInicial=Normal
VentanaExclusivaMDI=S
VentanaExclusiva=S
VentanaExclusivaOpcion=3
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=UsuarioMovImporteMaximo
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
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PermiteEditar=S
FiltroGeneral=UsuarioMovImporteMaximo.Usuario=<T>{Info.Usuario}<T>

[Lista.UsuarioMovImporteMaximo.Modulo]
Carpeta=Lista
Clave=UsuarioMovImporteMaximo.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
ColorFuente=Negro

[Lista.UsuarioMovImporteMaximo.Mov]
Carpeta=Lista
Clave=UsuarioMovImporteMaximo.Mov
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.UsuarioMovImporteMaximo.ImporteMaximo]
Carpeta=Lista
Clave=UsuarioMovImporteMaximo.ImporteMaximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

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
Modulo=47
Mov=166
ImporteMaximo=127
DescuentoGlobalMaximo=145
DescuentoLineaMaximo=142
DescuentoMaximo=125

[Acciones.NoDeducible]
Nombre=NoDeducible
Boton=47
NombreEnBoton=S
NombreDesplegar=Máximo &No Deducible
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=UsuarioNoDeducibleMaximo
Activo=S
Antes=S
DespuesGuardar=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Modulo, UsuarioMovImporteMaximo:UsuarioMovImporteMaximo.Modulo)<BR>Asigna(Info.Mov, UsuarioMovImporteMaximo:UsuarioMovImporteMaximo.Mov)
VisibleCondicion=UsuarioMovImporteMaximo:UsuarioMovImporteMaximo.Modulo=<T>GAS<T>

[Lista.UsuarioMovImporteMaximo.DescuentoGlobalMaximo]
Carpeta=Lista
Clave=UsuarioMovImporteMaximo.DescuentoGlobalMaximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.UsuarioMovImporteMaximo.DescuentoLineaMaximo]
Carpeta=Lista
Clave=UsuarioMovImporteMaximo.DescuentoLineaMaximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.UsuarioMovImporteMaximo.DescuentoMaximo]
Carpeta=Lista
Clave=UsuarioMovImporteMaximo.DescuentoMaximo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro


[Lista.ListaEnCaptura]
(Inicio)=UsuarioMovImporteMaximo.Modulo
UsuarioMovImporteMaximo.Modulo=UsuarioMovImporteMaximo.Mov
UsuarioMovImporteMaximo.Mov=UsuarioMovImporteMaximo.ImporteMaximo
UsuarioMovImporteMaximo.ImporteMaximo=UsuarioMovImporteMaximo.DescuentoMaximo
UsuarioMovImporteMaximo.DescuentoMaximo=UsuarioMovImporteMaximo.DescuentoGlobalMaximo
UsuarioMovImporteMaximo.DescuentoGlobalMaximo=UsuarioMovImporteMaximo.DescuentoLineaMaximo
UsuarioMovImporteMaximo.DescuentoLineaMaximo=(Fin)







[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=NoDeducible
NoDeducible=(Fin)
