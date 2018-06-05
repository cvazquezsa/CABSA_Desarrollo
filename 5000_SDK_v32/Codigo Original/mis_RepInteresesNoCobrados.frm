[Forma]
Clave=mis_RepInteresesNoCobrados
Nombre=Intereses No Cobrados
Icono=5
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=480
PosicionInicialArriba=354
PosicionInicialAltura=316
PosicionInicialAncho=320
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
AccionesTamanoBoton=15x5
ListaAcciones=(Lista)
AccionesDivision=S
AccionesCentro=S
BarraHerramientas=S
ExpresionesAlMostrar=Asigna(Info.ClienteD, SQL(<T>SELECT MIN(Cliente) FROM Cte<T>))<BR>Asigna(Info.ClienteA, SQL(<T>SELECT MAX(Cliente) FROM Cte<T>))<BR>Asigna(Info.CteCat,<T>(Todos)<T>)<BR>Asigna(Info.CteGrupo,<T>(Todos)<T>)<BR>Asigna(Info.CteFam,<T>(Todos)<T>)<BR>Asigna(Info.Moneda, Config.ContMoneda)<BR>Asigna(Info.Usuario,<T>(Todos)<T>)
PosicionInicialAlturaCliente=289

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
FichaEspacioEntreLineas=7
FichaEspacioNombres=53
FichaNombres=Clasico
FichaAlineacion=Izquierda
FichaColorFondo=Plata
ListaEnCaptura=(Lista)
PermiteEditar=S

[(Variables).Info.FechaD]
Carpeta=(Variables)
Clave=Info.FechaD
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
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CteCat]
Carpeta=(Variables)
Clave=Info.CteCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Moneda]
Carpeta=(Variables)
Clave=Info.Moneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[(Variables).Info.ClienteD]
Carpeta=(Variables)
Clave=Info.ClienteD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
EspacioPrevio=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.ClienteA]
Carpeta=(Variables)
Clave=Info.ClienteA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CteFam]
Carpeta=(Variables)
Clave=Info.CteFam
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.CteGrupo]
Carpeta=(Variables)
Clave=Info.CteGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[(Variables).Info.Usuario]
Carpeta=(Variables)
Clave=Info.Usuario
Editar=S
LineaNueva=N
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
EnBarraAcciones=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar / Ventana Aceptar
ListaAccionesMultiples=Variables Asignar<BR>mis_InteresesNoCobrados
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
ListaAccionesMultiples=Variables Asignar<BR>mis_InteresesNoCobrados
Activo=S
Visible=S

[Acciones.Imprimir.mis_InteresesNoCobrados]
Nombre=mis_InteresesNoCobrados
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=mis_InteresesNoCobrados

[Acciones.Preliminar.mis_InteresesNoCobrados]
Nombre=mis_InteresesNoCobrados
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=mis_InteresesNoCobrados

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=(Fin)

[(Variables).ListaEnCaptura]
(Inicio)=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=Info.ClienteD
Info.ClienteD=Info.ClienteA
Info.ClienteA=Info.CteCat
Info.CteCat=Info.CteFam
Info.CteFam=Info.CteGrupo
Info.CteGrupo=Info.Moneda
Info.Moneda=Info.Usuario
Info.Usuario=(Fin)
