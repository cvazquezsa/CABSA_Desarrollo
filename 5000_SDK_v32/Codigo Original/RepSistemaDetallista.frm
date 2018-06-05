[Forma]
Clave=RepSistemaDetallista
Nombre=Sistema Detallista
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=503
PosicionInicialArriba=433
PosicionInicialAltura=118
PosicionInicialAncho=270
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=25x5
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
VentanaExclusiva=S
BarraHerramientas=S
VentanaEscCerrar=S
PosicionInicialAlturaCliente=152

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.DepartamentoDetallistaD, SQL(<T>SELECT MIN(Departamento) FROM DepartamentoDetallista<T>))<BR>Asigna(Info.DepartamentoDetallistaA, SQL(<T>SELECT MAX(Departamento) FROM DepartamentoDetallista<T>))<BR>Asigna(Info.FechaA,  Hoy)<BR>Asigna(Info.Sucursal, Nulo)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={MS Sans Serif, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
Multiple=S
EnBarraAcciones=S
Activo=S
Visible=S
ListaAccionesMultiples=Variables Asignar<BR>SistemaDetallista
NombreEnBoton=S
EnBarraHerramientas=S

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

[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreDesplegar=&Imprimir
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=Variables Asignar<BR>SistemaDetallista
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S

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

[Acciones.Imprimir.SistemaDetallista]
Nombre=SistemaDetallista
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=SistemaDetallista
Activo=S
Visible=S

[Acciones.RepPan.SistemaDetallista]
Nombre=SistemaDetallista
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=SistemaDetallista
Activo=S
Visible=S

[(Variables).Info.DepartamentoDetallistaD]
Carpeta=(Variables)
Clave=Info.DepartamentoDetallistaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.DepartamentoDetallistaA]
Carpeta=(Variables)
Clave=Info.DepartamentoDetallistaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.FechaA]
Carpeta=(Variables)
Clave=Info.FechaA
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

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


[(Variables).ListaEnCaptura]
(Inicio)=Info.DepartamentoDetallistaD
Info.DepartamentoDetallistaD=Info.DepartamentoDetallistaA
Info.DepartamentoDetallistaA=Info.FechaA
Info.FechaA=Info.Sucursal
Info.Sucursal=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
