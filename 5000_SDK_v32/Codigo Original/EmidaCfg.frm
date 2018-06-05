
[Forma]
Clave=EmidaCfg
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Emida - Configuración
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
Comentarios=Empresa
PosicionInicialIzquierda=339
PosicionInicialArriba=158
PosicionInicialAlturaCliente=374
PosicionInicialAncho=601
ListaCarpetas=Datos
CarpetaPrincipal=Datos
[Acciones.GuardarCerrar]
Nombre=GuardarCerrar
Boton=3
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
GuardarAntes=S

NombreEnBoton=S
[Datos]
Estilo=Ficha
PestanaOtroNombre=S
PestanaNombre=Configuracion
Clave=Datos
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=EmidaCfg
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=134
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
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
FichaEspacioNombresAuto=S
FiltroGeneral=EmidaCfg.Empresa = <T>{Empresa}<T>
[Datos.EmidaCfg.Version]
Carpeta=Datos
Clave=EmidaCfg.Version
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco


Pegado=N

[Acciones.EmidaURLCfg]
Nombre=EmidaURLCfg
Boton=106
NombreEnBoton=S
NombreDesplegar=&Configuración URL
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=EmidaURLCfg
Activo=S
Visible=S






































GuardarAntes=S
[Acciones.ActualizarCatalogos]
Nombre=ActualizarCatalogos
Boton=7
NombreEnBoton=S
NombreDesplegar=Actuali&zar Catálogos
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
































































































EspacioPrevio=S

Expresion=ProcesarSQL(<T>EXEC spEmidaActualizarCatalogos :nEstacionTrabajo, :tEmpresa, :tUsuario, :nSucursal<T>, EstacionTrabajo, Empresa, Usuario, Sucursal)<BR><BR><BR>Si (SQL(<T>SELECT COUNT(*) FROM EmidaActualizarCatalogos WHERE Estacion = :nEstacion<T>, EstacionTrabajo) > 0)<BR>Entonces<BR>  Forma(<T>EmidaActualizarCatalogos<T>)<BR>Sino<BR>  Informacion(<T>No existen nuevos registros<T>)<BR>Fin
[Datos.EmidaCfg.TimeOut]
Carpeta=Datos
Clave=EmidaCfg.TimeOut
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Pegado=N
Tamano=18
EspacioPrevio=S
[Datos.EmidaCfg.Reintentos]
Carpeta=Datos
Clave=EmidaCfg.Reintentos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco









Pegado=N
Tamano=18












[Datos.EmidaCfg.Proveedor]
Carpeta=Datos
Clave=EmidaCfg.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco

[Datos.Prov.Nombre]
Carpeta=Datos
Clave=Prov.Nombre
Editar=N
3D=S
Tamano=40
ColorFondo=$00F0F0F0






[Lista.Columnas]
0=306
1=99






2=66
3=248
[Datos.EmidaCfg.MovOC]
Carpeta=Datos
Clave=EmidaCfg.MovOC
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=18
ColorFondo=Blanco













[Datos.EmidaCfg.TimeOutLookup]
Carpeta=Datos
Clave=EmidaCfg.TimeOutLookup
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco









[Datos.EmidaCfg.LogTransacciones]
Carpeta=Datos
Clave=EmidaCfg.LogTransacciones
Editar=S
LineaNueva=S
ValidaNombre=N
3D=S
EspacioPrevio=S
ColorFondo=Blanco

Tamano=30
[Datos.EmidaCfg.UbicacionLogTransacciones]
Carpeta=Datos
Clave=EmidaCfg.UbicacionLogTransacciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco











[Datos.EmidaCfg.NivelCfgSiteID]
Carpeta=Datos
Clave=EmidaCfg.NivelCfgSiteID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=18
ColorFondo=Blanco
























































































[Datos.ListaEnCaptura]
(Inicio)=EmidaCfg.NivelCfgSiteID
EmidaCfg.NivelCfgSiteID=EmidaCfg.Version
EmidaCfg.Version=EmidaCfg.TimeOut
EmidaCfg.TimeOut=EmidaCfg.TimeOutLookup
EmidaCfg.TimeOutLookup=EmidaCfg.Reintentos
EmidaCfg.Reintentos=EmidaCfg.Proveedor
EmidaCfg.Proveedor=Prov.Nombre
Prov.Nombre=EmidaCfg.MovOC
EmidaCfg.MovOC=EmidaCfg.LogTransacciones
EmidaCfg.LogTransacciones=EmidaCfg.UbicacionLogTransacciones
EmidaCfg.UbicacionLogTransacciones=(Fin)







































[Forma.ListaAcciones]
(Inicio)=GuardarCerrar
GuardarCerrar=EmidaURLCfg
EmidaURLCfg=ActualizarCatalogos
ActualizarCatalogos=(Fin)
