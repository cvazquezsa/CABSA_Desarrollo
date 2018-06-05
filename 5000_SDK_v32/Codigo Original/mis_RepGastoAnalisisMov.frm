[Forma]
Clave=mis_RepGastoAnalisisMov
Nombre=General de Movimientos   ( Gastos )
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
AccionesTamanoBoton=15x5
PosicionInicialAltura=392
PosicionInicialAncho=318
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialIzquierda=481
PosicionInicialArriba=316
SinCondicionDespliege=S
MovModulo=GAS
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos
BarraHerramientas=S
PosicionInicialAlturaCliente=365

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.AcreedorD, SQL(<T>SELECT Min(Proveedor) FROM Prov Where Rama =:trama<T>, <T>ACRE<T>))<BR>Asigna(Info.AcreedorA, SQL(<T>SELECT Max(Proveedor) FROM Prov Where Rama =:trama<T>, <T>ACRE<T>))<BR>Asigna(Info.MovClaveAfecta, <T><T>)<BR>Asigna(Info.Modulo, <T>GAS<T>)<BR>Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Info.ProvCat, <T>(Todos)<T>)<BR>Asigna(Info.ProvFam, <T>(Todos)<T>)<BR>Asigna(Info.Estatus, <T>Concluido<T>)<BR>Asigna(Info.Sucursal, Nulo)<BR>Asigna(Info.UEN, Nulo)<BR>Asigna(Info.Desglosar, <T>No<T>)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
FichaEspacioEntreLineas=7
FichaEspacioNombres=105
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Blanco
FichaAlineacionDerecha=S
FichaEspacioNombresAuto=S
PermiteEditar=S

[(Variables).Info.Sucursal]
Carpeta=(Variables)
Clave=Info.Sucursal
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[(Variables).Info.Moneda]
Carpeta=(Variables)
Clave=Info.Moneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Estatus]
Carpeta=(Variables)
Clave=Info.Estatus
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
LineaNueva=S

[(Variables).Info.Desglosar]
Carpeta=(Variables)
Clave=Info.Desglosar
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.AcreedorD]
Carpeta=(Variables)
Clave=Info.AcreedorD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.AcreedorA]
Carpeta=(Variables)
Clave=Info.AcreedorA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.ProvCat]
Carpeta=(Variables)
Clave=Info.ProvCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.ProvFam]
Carpeta=(Variables)
Clave=Info.ProvFam
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
EnBarraAcciones=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreEnBoton=S
NombreDesplegar=&Imprimir
Multiple=S
EnBarraHerramientas=S
EnMenu=S
EnBarraAcciones=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
ListaAccionesMultiples=Variables Asignar<BR>mis_GastoAnalisisMov
Activo=S
Visible=S

[Acciones.Preliminar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Variables Asignar<BR>mis_GastoAnalisisMov
Activo=S
Visible=S

[Acciones.Imprimir.mis_GastoAnalisisMov]
Nombre=mis_GastoAnalisisMov
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=mis_GastoAnalisisMov

[Acciones.Preliminar.mis_GastoAnalisisMov]
Nombre=mis_GastoAnalisisMov
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=mis_GastoAnalisisMov

[(Variables).Info.UEN]
Carpeta=(Variables)
Clave=Info.UEN
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.MovClaveAfecta]
Carpeta=(Variables)
Clave=Info.MovClaveAfecta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[(Variables).ListaEnCaptura]
(Inicio)=Info.AcreedorD
Info.AcreedorD=Info.AcreedorA
Info.AcreedorA=Info.ProvCat
Info.ProvCat=Info.ProvFam
Info.ProvFam=Info.Sucursal
Info.Sucursal=Info.UEN
Info.UEN=Info.MovClaveAfecta
Info.MovClaveAfecta=Info.Moneda
Info.Moneda=Info.Estatus
Info.Estatus=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.Desglosar
Info.Desglosar=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=(Fin)
