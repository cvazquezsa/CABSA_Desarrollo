[Forma]
Clave=mis_RepDineroAnalisisMov
Nombre=General de Movimientos  ( Dinero )
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
AccionesTamanoBoton=15x5
PosicionInicialAltura=231
PosicionInicialAncho=557
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
VentanaTipoMarco=Di�logo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialIzquierda=361
PosicionInicialArriba=396
SinCondicionDespliege=S
MovModulo=DIN
EsMovimiento=S
TituloAuto=S
MovEspecificos=Todos
BarraHerramientas=S
PosicionInicialAlturaCliente=204

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.CtaDineroD, SQL(<T>SELECT Min(CtaDinero) FROM CtaDinero<T>))<BR>Asigna(Info.CtaDineroA, SQL(<T>SELECT Max(CtaDinero) FROM CtaDinero<T>))<BR>Asigna(Info.MovClaveAfecta, <T><T>)<BR>Asigna(Info.Modulo, <T>DIN<T>)<BR>Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Info.Estatus, <T>Concluido<T>)<BR>Asigna(Info.Sucursal, Nulo)<BR>Asigna(Info.UEN, Nulo)
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
FichaNombres=Izquierda
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

[(Variables).Info.CtaDineroD]
Carpeta=(Variables)
Clave=Info.CtaDineroD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CtaDineroA]
Carpeta=(Variables)
Clave=Info.CtaDineroA
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
ListaAccionesMultiples=Variables Asignar<BR>mis_DineroAnalisisMov
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
NombreDesplegar=&Preliminar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Variables Asignar<BR>mis_DineroAnalisisMov
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Imprimir.mis_DineroAnalisisMov]
Nombre=mis_DineroAnalisisMov
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=mis_DineroAnalisisMov

[Acciones.Preliminar.mis_DineroAnalisisMov]
Nombre=mis_DineroAnalisisMov
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=mis_DineroAnalisisMov

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
(Inicio)=Info.CtaDineroD
Info.CtaDineroD=Info.CtaDineroA
Info.CtaDineroA=Info.Sucursal
Info.Sucursal=Info.UEN
Info.UEN=Info.MovClaveAfecta
Info.MovClaveAfecta=Info.Moneda
Info.Moneda=Info.Estatus
Info.Estatus=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=(Fin)
