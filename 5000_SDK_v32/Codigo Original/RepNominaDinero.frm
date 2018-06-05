[Forma]
Clave=RepNominaDinero
Nombre=<T>Movimientos - Dinero<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialIzquierda=291
PosicionInicialArriba=332
PosicionInicialAltura=104
PosicionInicialAncho=442
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
Comentarios=Info.Mov+<T> <T>+Info.MovID
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaEscCerrar=S

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Temp.Reg, SQL(<T>spVerUltimaNomina<T>))<BR>Asigna(Info.ID,    Temp.Reg[1])<BR>Asigna(Info.Mov,   Temp.Reg[2])<BR>Asigna(Info.MovID, Temp.Reg[3])<BR>Asigna(Rep.Titulo, <T>Movimientos - Dinero<T>)
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
FichaNombres=Arriba
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=Rep.Titulo

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

[Acciones.Nomina]
Nombre=Nomina
Boton=50
NombreEnBoton=S
NombreDesplegar=Nómina
EnBarraHerramientas=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
ConCondicion=S
Visible=S
EspacioPrevio=S
EjecucionCondicion=Forma(<T>EspecificarMovNomina<T>)

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
EspacioPrevio=S
ListaAccionesMultiples=Variables Asignar<BR>NominaDinero
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
ListaAccionesMultiples=Variables Asignar<BR>NominaDinero
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Preliminar.NominaDinero]
Nombre=NominaDinero
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=NominaDinero
Activo=S
Visible=S

[Acciones.Imprimir.NominaDinero]
Nombre=NominaDinero
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=NominaDinero
Activo=S
Visible=S

[(Variables).Rep.Titulo]
Carpeta=(Variables)
Clave=Rep.Titulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=60
ColorFondo=Blanco
ColorFuente=Negro





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=Preliminar
Preliminar=Nomina
Nomina=(Fin)
