
[Forma]
Clave=POSLDIEmpresa
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Configuración Empresa LDI
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Campos
CarpetaPrincipal=Campos
PosicionInicialAlturaCliente=80
PosicionInicialAncho=446
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=289
PosicionInicialArriba=304
Comentarios=Empresa
ListaAcciones=(Lista)
[Campos]
Estilo=Ficha
Clave=Campos
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSLDIEmpresa
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
ListaEnCaptura=POSLDIEmpresa.EmpresaLDI
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=POSLDIEmpresa.Empresa = <T>{Empresa}<T>
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S

[Campos.POSLDIEmpresa.EmpresaLDI]
Carpeta=Campos
Clave=POSLDIEmpresa.EmpresaLDI
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.POSLDISucursal]
Nombre=POSLDISucursal
Boton=50
NombreEnBoton=S
NombreDesplegar=Sucursales
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=POSLDISucursal
Activo=S
Visible=S




[Acciones.POSLDIServicio]
Nombre=POSLDIServicio
Boton=50
NombreEnBoton=S
NombreDesplegar=&Servicios
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=POSLDIServicio
Activo=S
Visible=S


[Acciones.POSLDIFormaPago]
Nombre=POSLDIFormaPago
Boton=64
NombreEnBoton=S
NombreDesplegar=Formas de Pago
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=POSLDIFormaPago
Activo=S
Visible=S































































































































[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=POSLDISucursal
POSLDISucursal=POSLDIServicio
POSLDIServicio=POSLDIFormaPago
POSLDIFormaPago=(Fin)
