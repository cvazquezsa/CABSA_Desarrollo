[Forma]
Clave=RepContReexResultados
Nombre=Actualización de Resultado del Ejercicio
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
PosicionInicialIzquierda=524
PosicionInicialArriba=475
PosicionInicialAlturaCliente=65
PosicionInicialAncho=351

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.Ejercicio, EjercicioTrabajo-1)
[(Variables)]
Estilo=Ficha
Clave=(Variables)
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
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
ListaEnCaptura=Info.Ejercicio
CarpetaVisible=S

[(Variables).Info.Ejercicio]
Carpeta=(Variables)
Clave=Info.Ejercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=38
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

[Acciones.Imprimir.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Imprimir.ContReexResultados]
Nombre=ContReexResultados
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=ContReexResultados
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
ListaAccionesMultiples=Variables Asignar<BR>ContReexResultados
Activo=S
Visible=S

[Acciones.RepPan.ContReexResultados]
Nombre=ContReexResultados
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=ContReexResultados
Activo=S
Visible=S

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
Multiple=S
EnBarraHerramientas=S
ListaAccionesMultiples=Variables Asignar<BR>ContReexResultados
Activo=S
Visible=S

[Acciones.RepPan.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S





[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
