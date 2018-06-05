

[Forma]
Clave=CFDIRetencionProv
Icono=0
Modulos=(Todos)
Nombre=CFDI Retenciones - Configuración Proveedores
MovModulo=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=GuardarCerrar
PosicionInicialIzquierda=185
PosicionInicialArriba=69
PosicionInicialAlturaCliente=552
PosicionInicialAncho=996
PosicionCol1=372
[Lista]
Estilo=Iconos
PestanaOtroNombre=S
PestanaNombre=Lista
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=CFDIRetencionProv
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=CFDIRetencionProv.Nombre

CarpetaVisible=S
OtroOrden=S
ValidarCampos=S

ListaOrden=CFDIRetencionProv.Proveedor<TAB>(Acendente)
BusquedaRapidaControles=S
FiltroModificarEstatus=S
FiltroCambiarPeriodo=S
FiltroBuscarEn=S
FiltroFechasCambiar=S
FiltroFechasNormal=S
FiltroFechasNombre=&Fecha
BusquedaRapida=S
BusquedaInicializar=S
BusquedaRespetarControles=S
BusquedaAncho=20
BusquedaEnLinea=S
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Proveedor<T>
ElementosPorPaginaEsp=200



IconosNombre=CFDIRetencionProv:CFDIRetencionProv.Proveedor
IconosConPaginas=S
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

[Lista.Columnas]
Proveedor=126
Pais=169
CFDIRetTipoContribuyente=150



Clave=41
Sujeto=604




0=-2
1=-2
Beneficiario=64
Nombre=205
Cliente=86
Nombre_1=181
Moneda=60
Nombre_2=85
[Lista.ListaEnCaptura]
(Inicio)=CFDIRetencionProv.Proveedor
CFDIRetencionProv.Proveedor=CFDIRetencionProv.Pais
CFDIRetencionProv.Pais=CFDIRetencionProv.CFDIRetTipoContribuyente
CFDIRetencionProv.CFDIRetTipoContribuyente=(Fin)

[Lista.CFDIRetencionProv.Nombre]
Carpeta=Lista
Clave=CFDIRetencionProv.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Configuracion]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Configuracion
Clave=Configuracion
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A2
Vista=CFDIRetencionProv
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

[Configuracion.CFDIRetencionProv.Pais]
Carpeta=Configuracion
Clave=CFDIRetencionProv.Pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

EspacioPrevio=S
[Configuracion.CFDIRetencionProv.CFDIRetTipoContribuyente]
Carpeta=Configuracion
Clave=CFDIRetencionProv.CFDIRetTipoContribuyente
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco







[Configuracion.CFDIRetencionProv.CFDIRetBeneficiarioNombre]
Carpeta=Configuracion
Clave=CFDIRetencionProv.CFDIRetBeneficiarioNombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=52
ColorFondo=Blanco

EspacioPrevio=S
[Configuracion.CFDIRetencionProv.CFDIRetBeneficiarioCURP]
Carpeta=Configuracion
Clave=CFDIRetencionProv.CFDIRetBeneficiarioCURP
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=30
ColorFondo=Blanco

[Configuracion.CFDIRetencionProv.CFDIRetBeneficiarioRFC]
Carpeta=Configuracion
Clave=CFDIRetencionProv.CFDIRetBeneficiarioRFC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco









[Configuracion.CFDIRetencionProv.Proveedor]
Carpeta=Configuracion
Clave=CFDIRetencionProv.Proveedor
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=12
ColorFondo=$00F0F0F0
Efectos=[Negritas]

[Configuracion.CFDIRetencionProv.Nombre]
Carpeta=Configuracion
Clave=CFDIRetencionProv.Nombre
3D=S
Pegado=S
Tamano=40
ColorFondo=$00F0F0F0
Efectos=[Negritas]













[Configuracion.CFDIRetencionProv.FiscalRegimen]
Carpeta=Configuracion
Clave=CFDIRetencionProv.FiscalRegimen
Editar=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco

LineaNueva=S






[Configuracion.CFDIRetencionProv.eMail1]
Carpeta=Configuracion
Clave=CFDIRetencionProv.eMail1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=52
ColorFondo=Blanco




[Configuracion.ListaEnCaptura]
(Inicio)=CFDIRetencionProv.Proveedor
CFDIRetencionProv.Proveedor=CFDIRetencionProv.Nombre
CFDIRetencionProv.Nombre=CFDIRetencionProv.eMail1
CFDIRetencionProv.eMail1=CFDIRetencionProv.Pais
CFDIRetencionProv.Pais=CFDIRetencionProv.CFDIRetTipoContribuyente
CFDIRetencionProv.CFDIRetTipoContribuyente=CFDIRetencionProv.FiscalRegimen
CFDIRetencionProv.FiscalRegimen=CFDIRetencionProv.CFDIRetBeneficiarioNombre
CFDIRetencionProv.CFDIRetBeneficiarioNombre=CFDIRetencionProv.CFDIRetBeneficiarioCURP
CFDIRetencionProv.CFDIRetBeneficiarioCURP=CFDIRetencionProv.CFDIRetBeneficiarioRFC
CFDIRetencionProv.CFDIRetBeneficiarioRFC=(Fin)















[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Configuracion
Configuracion=(Fin)
