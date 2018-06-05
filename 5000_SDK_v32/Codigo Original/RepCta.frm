[Forma]
Clave=RepCta
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=286
PosicionInicialArriba=305
PosicionInicialAltura=158
PosicionInicialAncho=451
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
AccionesTamanoBoton=25x5
AccionesCentro=S
ListaAcciones=(Lista)
AccionesDivision=S
Nombre=Rep.Titulo
BarraHerramientas=S
VentanaEscCerrar=S

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.Ejercicio, EjercicioTrabajo) <BR>Asigna(Info.PeriodoD, 1);<BR>Asigna(Info.PeriodoA, PeriodoTrabajo)<BR>Asigna(Info.ConMovimientos, <T>No<T>)<BR>Asigna(Rep.Titulo, <T>Catálogo de Cuentas<T>)<BR>Asigna(Info.CtaTipo, TipoAuxiliar)<BR>Asigna(Info.CuentaD, SQL(<T>SELECT MIN(Cuenta) FROM Cta WHERE Tipo<>:tTipo<T>, TipoEstructura))<BR>Asigna(Info.CuentaA, SQL(<T>SELECT MAX(Cuenta) FROM Cta WHERE Tipo<>:tTipo<T>, TipoEstructura))
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
CarpetaVisible=S
FichaEspacioEntreLineas=8
FichaEspacioNombres=75
FichaEspacioNombresAuto=S
FichaNombres=Arriba
FichaColorFondo=Plata
FichaAlineacion=Izquierda
ListaEnCaptura=(Lista)
PermiteEditar=S

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
Multiple=S
EnBarraAcciones=S
ListaAccionesMultiples=Asignar<BR>Cta
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S

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
TipoAccion=Reportes Impresora
ListaAccionesMultiples=Variables Asignar<BR>Cta
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S

[Acciones.RepPan.Asignar]
Nombre=Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[(Variables).Info.CtaNivel]
Carpeta=(Variables)
Clave=Info.CtaNivel
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Rep.Titulo]
Carpeta=(Variables)
Clave=Rep.Titulo
Editar=S
ValidaNombre=S
3D=S
Tamano=40
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.RepPan.Cta]
Nombre=Cta
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=Cta
Activo=S
Visible=S

[Acciones.Imprimir.Cta]
Nombre=Cta
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=Cta
Activo=S
Visible=S

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

[(Variables).Info.CuentaD]
Carpeta=(Variables)
Clave=Info.CuentaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CuentaA]
Carpeta=(Variables)
Clave=Info.CuentaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro


[(Variables).ListaEnCaptura]
(Inicio)=Info.CtaNivel
Info.CtaNivel=Rep.Titulo
Rep.Titulo=Info.CuentaD
Info.CuentaD=Info.CuentaA
Info.CuentaA=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
