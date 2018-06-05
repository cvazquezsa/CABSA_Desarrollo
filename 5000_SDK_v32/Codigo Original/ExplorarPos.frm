[Forma]
Clave=ExplorarPos
Nombre=Posición de la Empresa
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=357
PosicionInicialArriba=216
PosicionInicialAltura=329
PosicionInicialAncho=310
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
ExpresionesAlMostrar=Asigna(Pos.ConDinero, <T>Si<T>)<BR>Asigna(Pos.ConCxc, <T>Si<T>)<BR>Asigna(Pos.ConCxp, <T>Si<T>)<BR>Asigna(Pos.ConGastos, <T>Si<T>)<BR>Asigna(Pos.ConInv, <T>No<T>)<BR>Asigna(Pos.ConCompras, <T>No<T>)<BR>Asigna(Pos.ConVentas, <T>No<T>)<BR>Asigna(Pos.Intervalo, 7)<BR>Asigna(Pos.SimularMeses, 3)<BR>Asigna(Pos.MonedaVer, <T>Convertir Todo a<T>)<BR>Asigna(Info.Moneda, Config.ContMoneda)
PosicionInicialAlturaCliente=302

[(Variables)]
Estilo=Ficha
Clave=(Variables)
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PermiteEditar=S

[Acciones.RepPan.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.RepPan.FlujoEfectivo]
Nombre=FlujoEfectivo
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=FlujoEfectivo
Activo=S
Visible=S

[Acciones.Imprimir.FlujoEfectivo]
Nombre=FlujoEfectivo
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=FlujoEfectivo
Activo=S
Visible=S

[(Variables).Pos.ConDinero]
Carpeta=(Variables)
Clave=Pos.ConDinero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[(Variables).Pos.ConCxc]
Carpeta=(Variables)
Clave=Pos.ConCxc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Pos.ConCxp]
Carpeta=(Variables)
Clave=Pos.ConCxp
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Pos.ConGastos]
Carpeta=(Variables)
Clave=Pos.ConGastos
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Pos.ConInv]
Carpeta=(Variables)
Clave=Pos.ConInv
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Pos.ConCompras]
Carpeta=(Variables)
Clave=Pos.ConCompras
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Pos.ConVentas]
Carpeta=(Variables)
Clave=Pos.ConVentas
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Pos.Intervalo]
Carpeta=(Variables)
Clave=Pos.Intervalo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[(Variables).Pos.SimularMeses]
Carpeta=(Variables)
Clave=Pos.SimularMeses
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Pos.MonedaVer]
Carpeta=(Variables)
Clave=Pos.MonedaVer
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

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Explorar]
Nombre=Explorar
Boton=66
NombreEnBoton=S
NombreDesplegar=&Explorar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=ExplorarPosModulo
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Variables Asignar<BR>Expresion<BR>ExplorarPosModulo

[Acciones.Explorar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Explorar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=EjecutarSQL(<T>spGenerarPos :tEmp, :nEstacion, :tMoneda, :tMonedaVer, :nMeses, :nIntervalo, :tDinero, :tInv, :tCxc, :tCxp, :tGastos, :tVentas, :tCompras, :tNivel<T>,<BR>Empresa, EstacionTrabajo, Info.Moneda, Pos.MonedaVer, Pos.SimularMeses, Pos.Intervalo, Pos.ConDinero, Pos.ConInv, Pos.ConCxc, Pos.ConCxp, Pos.ConGastos, Pos.ConVentas, Pos.ConCompras, <T>MODULO<T>)

[Acciones.Explorar.ExplorarPosModulo]
Nombre=ExplorarPosModulo
Boton=0
TipoAccion=Formas
ClaveAccion=ExplorarPosModulo
Activo=S
Visible=S

[Acciones.Simular]
Nombre=Simular
Boton=20
NombreEnBoton=S
NombreDesplegar=&Simular
EnBarraHerramientas=S
TipoAccion=Expresion
Visible=S


[(Variables).ListaEnCaptura]
(Inicio)=Pos.Intervalo
Pos.Intervalo=Pos.SimularMeses
Pos.SimularMeses=Pos.ConDinero
Pos.ConDinero=Pos.ConInv
Pos.ConInv=Pos.ConCxc
Pos.ConCxc=Pos.ConVentas
Pos.ConVentas=Pos.ConCxp
Pos.ConCxp=Pos.ConGastos
Pos.ConGastos=Pos.ConCompras
Pos.ConCompras=Pos.MonedaVer
Pos.MonedaVer=Info.Moneda
Info.Moneda=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Explorar
Explorar=Simular
Simular=(Fin)
