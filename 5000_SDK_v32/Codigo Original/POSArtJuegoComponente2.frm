
[Forma]
Clave=POSArtJuegoComponente2
Icono=0
CarpetaPrincipal=(Variables)
Modulos=(Todos)
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal

ListaCarpetas=(Lista)
PosicionInicialIzquierda=436
PosicionInicialArriba=166
PosicionInicialAlturaCliente=489
PosicionInicialAncho=728
PosicionSec1=104

PosicionSec2=335
Nombre=Código Componentes
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaSinIconosMarco=S
ExpresionesAlMostrar=Asigna(Ver.Aviso,<T>INGRESE EL COMPONENTE<T>)<BR>Asigna(Info.Codigo,Nulo)<BR>Asigna(Info.Numero,Nulo)
ExpresionesAlCerrar=EjecutarSQL( <T>spPOSInsertarArtComponentes :nEstacion, :tID, :tEmpresa, :nSucursal, :nRenglonID, :tArticulo, :nCantidad<T>,POSArtJuegoComponente:POSArtJuegoComponente.Estacion,POSArtJuegoComponente:POSArtJuegoComponente.RID,Empresa,Sucursal,POSArtJuegoComponente:POSArtJuegoComponente.RenglonID,POSArtJuegoComponente:POSArtJuegoComponente.Articulo,POSArtJuegoComponente:POSArtJuegoComponente.Cantidad )
[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 36, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=$00C6FFFF
ListaEnCaptura=Info.Codigo
CarpetaVisible=S

PermiteEditar=S
FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Negro
ConFuenteEspecial=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
CampoAccionAlEnter=Enter
[(Variables).Info.Codigo]
Carpeta=(Variables)
Clave=Info.Codigo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=$00C6FFFF



AccionAlEnter=Enter
AccionAlEnterBloquearAvance=S
[POSArtJuegoComponente.POSArtJuegoComponente.Componente]
Carpeta=POSArtJuegoComponente
Clave=POSArtJuegoComponente.Componente
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=$00C6FFFF

[POSArtJuegoComponente.POSArtJuegoComponente.ArtSubCuenta]
Carpeta=POSArtJuegoComponente
Clave=POSArtJuegoComponente.ArtSubCuenta
Editar=N
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=$00C1FFFF





[POSArtJuegoComponente.Columnas]
Componente=205
ArtSubCuenta=473


Opcion=516
[POSArtJuegoComponente]
Estilo=Hoja
Clave=POSArtJuegoComponente
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=B1
Vista=POSArtJuegoComponente
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=$00C1FFFF
ListaEnCaptura=(Lista)

CarpetaVisible=S










HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
HojaFondoGris=S
[Mensaje]
Estilo=Ficha
Clave=Mensaje
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=C1
Vista=(Variables)
Fuente={Tahoma, 24, Negro, []}
CampoColorLetras=Lima
CampoColorFondo=Negro
ListaEnCaptura=Ver.Aviso
CarpetaVisible=S

FichaEspacioEntreLineas=0
FichaEspacioNombres=0
FichaColorFondo=Negro
ConFuenteEspecial=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
[Mensaje.Ver.Aviso]
Carpeta=Mensaje
Clave=Ver.Aviso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=35x2
ColorFondo=Negro


































ColorFuente=Lima
[Acciones.Enter]
Nombre=Enter
Boton=0
NombreDesplegar=Enter
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S

Multiple=S
ListaAccionesMultiples=(Lista)

[Acciones.Enter.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Enter.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S



















Expresion=Asigna(Ver.Aviso,SQL(<T>spPOSGenerarComponenteCB :tID, :tCodigo, :nEstacion, :tArticulo, :nRenglonID<T>,POSArtJuegoComponente:POSArtJuegoComponente.RID,Info.Codigo,POSArtJuegoComponente:POSArtJuegoComponente.Estacion,POSArtJuegoComponente:POSArtJuegoComponente.Articulo,POSArtJuegoComponente:POSArtJuegoComponente.RenglonID))<BR>Asigna(Info.Codigo,Nulo)<BR>ActualizarForma




[Acciones.Enter.Cerrar]
Nombre=Cerrar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
ConCondicion=S
Visible=S



EjecucionCondicion=Asigna(Info.Numero,SQL(<T> SELECT dbo.fnPOSValidarComponenteCB( :tID, :nEstacion,:nRenglonID )<T>,POSArtJuegoComponente:POSArtJuegoComponente.RID,POSArtJuegoComponente:POSArtJuegoComponente.Estacion,POSArtJuegoComponente:POSArtJuegoComponente.RenglonID))<BR>Info.Numero = 0


[Acciones.Enter.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=Expresion
Expresion=Cerrar
Cerrar=(Fin)


































[POSArtJuegoComponente.ListaEnCaptura]
(Inicio)=POSArtJuegoComponente.Componente
POSArtJuegoComponente.Componente=POSArtJuegoComponente.ArtSubCuenta
POSArtJuegoComponente.ArtSubCuenta=(Fin)












[Acciones.Cancelar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=EjecutarSQL(<T>spPOSCancelarComponente :tID, :nRenglonID, :tArticulo, :nEstacion<T>,POSArtJuegoComponente:POSArtJuegoComponente.RID,POSArtJuegoComponente:POSArtJuegoComponente.RenglonID,POSArtJuegoComponente:POSArtJuegoComponente.Articulo,EstacionTrabajo)
[Acciones.Cancelar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cancelar
GuardarAntes=S
Multiple=S
EnBarraHerramientas=S
TipoAccion=Expresion
ListaAccionesMultiples=(Lista)

Activo=S
Visible=S









[Acciones.Cancelar.ListaAccionesMultiples]
(Inicio)=Expresion
Expresion=Aceptar
Aceptar=(Fin)



[Forma.ListaCarpetas]
(Inicio)=(Variables)
(Variables)=POSArtJuegoComponente
POSArtJuegoComponente=Mensaje
Mensaje=(Fin)

[Forma.ListaAcciones]
(Inicio)=Enter
Enter=Cancelar
Cancelar=(Fin)
