[Forma]
Clave=PC_H2
Nombre=<T>Herramienta Precios<T>
Icono=34
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=414
PosicionInicialArriba=307
PosicionInicialAlturaCliente=550
PosicionInicialAncho=1092
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov, Info.MovID)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S

[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PC_H2
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
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
FiltroRespetar=S
FiltroTipo=General
HojaAjustarColumnas=S
HojaMantenerSeleccion=S
FiltroGeneral=PC_H2.Estacion={EstacionTrabajo} AND<BR>PC_H2.ID={Info.ID}

[Lista.PC_H2.Articulo]
Carpeta=Lista
Clave=PC_H2.Articulo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Plata
ColorFuente=Negro

[Lista.PC_H2.SubCuenta]
Carpeta=Lista
Clave=PC_H2.SubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Lista.PC_H2.Unidad]
Carpeta=Lista
Clave=PC_H2.Unidad
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Plata
ColorFuente=Negro

[Lista.PC_H2.CostoBase]
Carpeta=Lista
Clave=PC_H2.CostoBase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFuente=Negro
IgnoraFlujo=S
ColorFondo=Blanco

[Lista.PC_H2.Margen]
Carpeta=Lista
Clave=PC_H2.Margen
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PC_H2.Variacion]
Carpeta=Lista
Clave=PC_H2.Variacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=124
SubCuenta=96
Unidad=42
CostoBase=91
Margen=43
Variacion=48
Descripcion1=249
Nuevo=104
Anterior=115
Redondear=56
Redondeo=51
ListaModificar=97
Impuesto1=24

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Plata
ColorFuente=Negro

[Acciones.CambiarVista]
Nombre=CambiarVista
Boton=0
NombreDesplegar=CambiarVista
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
Activo=S
Visible=S

[Lista.PC_H2.Nuevo]
Carpeta=Lista
Clave=PC_H2.Nuevo
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]

[Lista.PC_H2.Anterior]
Carpeta=Lista
Clave=PC_H2.Anterior
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

[Lista.PC_H2.Redondear]
Carpeta=Lista
Clave=PC_H2.Redondear
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.PC_H2.Redondeo]
Carpeta=Lista
Clave=PC_H2.Redondeo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
EspacioPrevio=S

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
Antes=S
DespuesGuardar=S
AntesExpresiones=EjecutarSQL(<T>spPC_H2 :nEstacion, :nID, :tAccion<T>, EstacionTrabajo, Info.ID, <T>ACEPTAR<T>)

[Lista.PC_H2.ListaModificar]
Carpeta=Lista
Clave=PC_H2.ListaModificar
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Preliminar]
Nombre=Preliminar
Boton=51
NombreDesplegar=Preliminar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PC_H2Preliminar
Activo=S
Visible=S

[Lista.PC_H2.Impuesto1]
Carpeta=Lista
Clave=PC_H2.Impuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Guardar
Guardar=CambiarVista
CambiarVista=Preliminar
Preliminar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=PC_H2.Articulo
PC_H2.Articulo=Art.Descripcion1
Art.Descripcion1=PC_H2.SubCuenta
PC_H2.SubCuenta=PC_H2.Unidad
PC_H2.Unidad=PC_H2.ListaModificar
PC_H2.ListaModificar=PC_H2.CostoBase
PC_H2.CostoBase=PC_H2.Margen
PC_H2.Margen=PC_H2.Variacion
PC_H2.Variacion=PC_H2.Redondear
PC_H2.Redondear=PC_H2.Redondeo
PC_H2.Redondeo=PC_H2.Impuesto1
PC_H2.Impuesto1=PC_H2.Nuevo
PC_H2.Nuevo=PC_H2.Anterior
PC_H2.Anterior=(Fin)
