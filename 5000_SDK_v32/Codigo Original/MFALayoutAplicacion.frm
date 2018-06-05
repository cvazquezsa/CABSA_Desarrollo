
[Forma]
Clave=MFALayoutAplicacion
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
Nombre=<T>MFA - Captura manual aplicaciones<T>

ListaCarpetas=Lista
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=288
PosicionInicialArriba=208
PosicionInicialAlturaCliente=273
PosicionInicialAncho=789
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Ejercicio,Info.Periodo)
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFALayoutAplicacion
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

FiltroGeneral=PeriodoID = {Comillas(Info.Titulo)}
[Lista.MFALayoutAplicacion.origen_id]
Carpeta=Lista
Clave=MFALayoutAplicacion.origen_id
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MFALayoutAplicacion.empresa]
Carpeta=Lista
Clave=MFALayoutAplicacion.empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.MFALayoutAplicacion.tipo_aplicacion]
Carpeta=Lista
Clave=MFALayoutAplicacion.tipo_aplicacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFALayoutAplicacion.folio]
Carpeta=Lista
Clave=MFALayoutAplicacion.folio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFALayoutAplicacion.fecha]
Carpeta=Lista
Clave=MFALayoutAplicacion.fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.Columnas]
origen_id=208
empresa=70
tipo_aplicacion=131
folio=132
fecha=130

0=-2
1=88
2=-2
origen_modulo=70
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S







GuardarAntes=S

[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MFALayoutAplicacionD
Activo=S
Antes=S
Visible=S









DespuesGuardar=S


























AntesExpresiones=Asigna(Info.MovID, MFALayoutAplicacion:MFALayoutAplicacion.folio)<BR>Asigna(Info.Categoria, SQL(<T>SELECT DocumentoID FROM MFALayoutAplicacion WHERE RID = :nRID<T>, MFALayoutAplicacion:MFALayoutAplicacion.RID))
[Lista.MFALayoutAplicacion.origen_modulo]
Carpeta=Lista
Clave=MFALayoutAplicacion.origen_modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco
















[Lista.ListaEnCaptura]
(Inicio)=MFALayoutAplicacion.origen_modulo
MFALayoutAplicacion.origen_modulo=MFALayoutAplicacion.origen_id
MFALayoutAplicacion.origen_id=MFALayoutAplicacion.empresa
MFALayoutAplicacion.empresa=MFALayoutAplicacion.tipo_aplicacion
MFALayoutAplicacion.tipo_aplicacion=MFALayoutAplicacion.folio
MFALayoutAplicacion.folio=MFALayoutAplicacion.fecha
MFALayoutAplicacion.fecha=(Fin)



[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Detalle
Detalle=(Fin)
