[Forma]
Clave=PC_H2Preliminar
Nombre=<T>Herramienta Precios<T>
Icono=44
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=426
PosicionInicialArriba=307
PosicionInicialAlturaCliente=550
PosicionInicialAncho=1068
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov, Info.MovID)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PC_H2
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Plata
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
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Artículo<T>
ElementosPorPagina=200
PestanaOtroNombre=S
IconosNombre=PC_H2:PC_H2.Articulo
FiltroGeneral=PC_H2.Estacion={EstacionTrabajo} AND<BR>PC_H2.ID={Info.ID}

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
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Plata
ColorFuente=Negro

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
0=129
1=169

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

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Imprimir
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=Presentación preliminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Presentacion preliminar
Activo=S
Visible=S

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Enviar a Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar a Excel
Activo=S
Visible=S

[Acciones.Personalizar]
Nombre=Personalizar
Boton=45
NombreDesplegar=Personalizar
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Mostrar Campos
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Imprimir
Imprimir=Preliminar
Preliminar=Excel
Excel=Personalizar
Personalizar=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=Art.Descripcion1
Art.Descripcion1=PC_H2.SubCuenta
PC_H2.SubCuenta=PC_H2.Unidad
PC_H2.Unidad=PC_H2.ListaModificar
PC_H2.ListaModificar=PC_H2.CostoBase
PC_H2.CostoBase=PC_H2.Margen
PC_H2.Margen=PC_H2.Variacion
PC_H2.Variacion=PC_H2.Redondear
PC_H2.Redondear=PC_H2.Redondeo
PC_H2.Redondeo=PC_H2.Nuevo
PC_H2.Nuevo=PC_H2.Anterior
PC_H2.Anterior=(Fin)
