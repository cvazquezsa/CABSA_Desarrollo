[Forma]
Clave=FacturarVentaNOSugerida
Nombre=Factura Sugerida
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=229
PosicionInicialArriba=247
PosicionInicialAlturaCliente=502
PosicionInicialAncho=822
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
Totalizadores=S
PosicionSeccion1=90

[Lista]
Estilo=Hoja
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SugerirFacturaNConsumo
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
PermiteEditar=S
ListaEnCaptura=(Lista)
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=SugerirFacturaNConsumo.Estacion={EstacionTrabajo}

[Lista.SugerirFacturaNConsumo.Articulo]
Carpeta=Lista
Clave=SugerirFacturaNConsumo.Articulo
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=
ColorFondo=Blanco
ColorFuente=Negro
Editar=N

[Lista.SugerirFacturaNConsumo.SubCuenta]
Carpeta=Lista
Clave=SugerirFacturaNConsumo.SubCuenta
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SugerirFacturaNConsumo.Cantidad]
Carpeta=Lista
Clave=SugerirFacturaNConsumo.Cantidad
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SugerirFacturaNConsumo.Unidad]
Carpeta=Lista
Clave=SugerirFacturaNConsumo.Unidad
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SugerirFacturaNConsumo.Importe]
Carpeta=Lista
Clave=SugerirFacturaNConsumo.Importe
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Columnas]
Articulo=124
SubCuenta=104
Cantidad=48
Unidad=52
Importe=79
ImporteCliente=109
ImporteAseguradora=110
Descripcion1=184
EstaCubierto=69

[Lista.Art.Descripcion1]
Carpeta=Lista
Clave=Art.Descripcion1
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

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
TipoAccion=Ventana
ListaAccionesMultiples=Cancelar Cambios<BR>Cancelar
Activo=S
Visible=S

[Acciones.Cambiar Vista Hoja (Normal-Detalle)]
Nombre=Cambiar Vista Hoja (Normal-Detalle)
Boton=0
NombreDesplegar=Cambiar Vista Hoja (Normal-Detalle)
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Herramientas Captura
ClaveAccion=Cambiar Vista Hoja (Normal-Detalle)
Activo=S
Visible=S

[(Carpeta Totalizadores)]
Clave=(Carpeta Totalizadores)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
Totalizadores1=Importe Cliente<BR>Importe Aseguradora
Totalizadores2=Suma(SugerirFacturaNConsumo:ImporteCliente)<BR>Suma(SugerirFacturaNConsumo:ImporteAseguradora)
Totalizadores3=(Monetario)<BR>(Monetario)
Totalizadores=S
TotCarpetaRenglones=Lista
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Carpeta Totalizadores).Importe Cliente]
Carpeta=(Carpeta Totalizadores)
Clave=Importe Cliente
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[(Carpeta Totalizadores).Importe Aseguradora]
Carpeta=(Carpeta Totalizadores)
Clave=Importe Aseguradora
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Plata
ColorFuente=Negro
Efectos=[Negritas]
Pegado=S

[Lista.ImporteCliente]
Carpeta=Lista
Clave=ImporteCliente
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.ImporteAseguradora]
Carpeta=Lista
Clave=ImporteAseguradora
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.SugerirFacturaNConsumo.EstaCubierto]
Carpeta=Lista
Clave=SugerirFacturaNConsumo.EstaCubierto
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
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=Cambiar Vista Hoja (Normal-Detalle)
Cambiar Vista Hoja (Normal-Detalle)=(Fin)

[Lista.ListaEnCaptura]
(Inicio)=SugerirFacturaNConsumo.Articulo
SugerirFacturaNConsumo.Articulo=Art.Descripcion1
Art.Descripcion1=SugerirFacturaNConsumo.SubCuenta
SugerirFacturaNConsumo.SubCuenta=SugerirFacturaNConsumo.Cantidad
SugerirFacturaNConsumo.Cantidad=SugerirFacturaNConsumo.Unidad
SugerirFacturaNConsumo.Unidad=SugerirFacturaNConsumo.Importe
SugerirFacturaNConsumo.Importe=ImporteCliente
ImporteCliente=ImporteAseguradora
ImporteAseguradora=SugerirFacturaNConsumo.EstaCubierto
SugerirFacturaNConsumo.EstaCubierto=(Fin)

[(Carpeta Totalizadores).ListaEnCaptura]
(Inicio)=Importe Cliente
Importe Cliente=Importe Aseguradora
Importe Aseguradora=(Fin)
