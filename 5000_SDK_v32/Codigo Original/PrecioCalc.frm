[Forma]
Clave=PrecioCalc
Nombre=Precios Calculados
Icono=0
Modulos=(Todos)
ListaCarpetas=(Lista)
CarpetaPrincipal=Detalle
PosicionInicialIzquierda=351
PosicionInicialArriba=374
PosicionInicialAltura=269
PosicionInicialAncho=574
PosicionColumna1=44
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=242
PosicionCol1=250

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=PrecioCalc
Fuente={Tahoma, 8, Negro, []}
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=PrecioCalc.ListaPrecios
CarpetaVisible=S
HojaMantenerSeleccion=S
OtroOrden=S
ListaOrden=PrecioCalc.Orden<TAB>(Acendente)

[Lista.PrecioCalc.ListaPrecios]
Carpeta=Lista
Clave=PrecioCalc.ListaPrecios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
ListaPrecios=219
Base=124
Usar=124
Porcentaje=64
Redondear=64

[Detalle]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Lista Precios Calculada
Clave=Detalle
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=PrecioCalc
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
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Detalle.PrecioCalc.ListaPrecios]
Carpeta=Detalle
Clave=PrecioCalc.ListaPrecios
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Detalle.PrecioCalc.Base]
Carpeta=Detalle
Clave=PrecioCalc.Base
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.PrecioCalc.Usar]
Carpeta=Detalle
Clave=PrecioCalc.Usar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.PrecioCalc.Porcentaje]
Carpeta=Detalle
Clave=PrecioCalc.Porcentaje
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco
ColorFuente=Negro

[Detalle.PrecioCalc.Redondear]
Carpeta=Detalle
Clave=PrecioCalc.Redondear
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
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

[Detalle.PrecioCalc.Activa]
Carpeta=Detalle
Clave=PrecioCalc.Activa
Editar=S
LineaNueva=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Nuevo]
Nombre=Nuevo
Boton=1
NombreEnBoton=S
NombreDesplegar=&Nuevo
EnBarraHerramientas=S
EspacioPrevio=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Agregar
Activo=S
Visible=S

[Acciones.Eliminar]
Nombre=Eliminar
Boton=5
NombreEnBoton=S
NombreDesplegar=E&liminar
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Registro Eliminar
Activo=S
Visible=S

[Acciones.Navegador]
Nombre=Navegador
Boton=0
NombreDesplegar=Navegador
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Navegador 1 (Registros)
Activo=S
Visible=S

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar Orden
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Antes=S
GuardarAntes=S
DespuesGuardar=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Forma(<T>PrecioCalcOrdenar<T>)

[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Detalle
Detalle=(Fin)

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Nuevo
Nuevo=Eliminar
Eliminar=Navegador
Navegador=Ordenar
Ordenar=(Fin)

[Detalle.ListaEnCaptura]
(Inicio)=PrecioCalc.ListaPrecios
PrecioCalc.ListaPrecios=PrecioCalc.Base
PrecioCalc.Base=PrecioCalc.Usar
PrecioCalc.Usar=PrecioCalc.Porcentaje
PrecioCalc.Porcentaje=PrecioCalc.Redondear
PrecioCalc.Redondear=PrecioCalc.Activa
PrecioCalc.Activa=(Fin)
