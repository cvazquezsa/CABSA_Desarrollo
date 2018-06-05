[Forma]
Clave=SerieLoteCalidad
Nombre=Control de Calidad
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=254
PosicionInicialArriba=339
PosicionInicialAlturaCliente=311
PosicionInicialAncho=771
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
Comentarios=Lista(Info.Articulo, Info.SerieLote)
VentanaExclusiva=S
VentanaEscCerrar=S
ExpresionesAlMostrar=EjecutarSQL(<T>spSerieLoteCalidad :tEmpresa, :tArt, :tSub, :tLote<T>, Empresa, Info.Articulo, Info.SubCuenta, Info.SerieLote)

[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SerieLoteCalidad
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Gris
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
HojaMantenerSeleccion=S
FiltroGeneral=SerieLoteCalidad.Empresa=<T>{Empresa}<T> <BR>AND SerieLoteCalidad.Articulo=<T>{Info.Articulo}<T><BR>AND SerieLoteCalidad.SubCuenta=<T>{Info.SubCuenta}<T><BR>AND SerieLoteCalidad.SerieLote=<T>{Info.SerieLote}<T>

[Lista.SerieLoteCalidad.Evaluacion]
Carpeta=Lista
Clave=SerieLoteCalidad.Evaluacion
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Gris

[Lista.SerieLoteCalidad.Valor]
Carpeta=Lista
Clave=SerieLoteCalidad.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Evaluacion=256
Valor=64
Fecha=80
Referencia=157
Unidad=61
Metodo=119

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

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar Cambios]
Nombre=Cancelar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
TipoAccion=Ventana
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Lista.SerieLoteCalidad.Fecha]
Carpeta=Lista
Clave=SerieLoteCalidad.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SerieLoteCalidad.Referencia]
Carpeta=Lista
Clave=SerieLoteCalidad.Referencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Anexos]
Nombre=Anexos
Boton=77
NombreEnBoton=S
NombreDesplegar=Ane&xos
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=AnexoCta
Activo=S
Antes=S
AntesExpresiones=Asigna(Info.Rama, <T>SL<T>)<BR>Asigna(Info.AnexoCfg, Verdadero)<BR>Asigna(Info.Cuenta, Info.SerieLote)<BR>Asigna(Info.Descripcion, Info.SerieLote)
Visible=S
RefrescarDespues=S

[Lista.ArtCalidad.Unidad]
Carpeta=Lista
Clave=ArtCalidad.Unidad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris

[Lista.ArtCalidad.Metodo]
Carpeta=Lista
Clave=ArtCalidad.Metodo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Gris

[Acciones.VerMetodo]
Nombre=VerMetodo
Boton=90
NombreEnBoton=S
NombreDesplegar=Ver &Método
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=VerComentario(SerieLoteCalidad:ArtCalidad.Metodo, SQL(<T>SELECT Descripcion FROM Metodo WHERE Metodo=:tMetodo<T>, SerieLoteCalidad:ArtCalidad.Metodo) )

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Anexos
Anexos=VerMetodo
VerMetodo=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SerieLoteCalidad.Evaluacion
SerieLoteCalidad.Evaluacion=ArtCalidad.Unidad
ArtCalidad.Unidad=ArtCalidad.Metodo
ArtCalidad.Metodo=SerieLoteCalidad.Valor
SerieLoteCalidad.Valor=SerieLoteCalidad.Fecha
SerieLoteCalidad.Fecha=SerieLoteCalidad.Referencia
SerieLoteCalidad.Referencia=(Fin)
