[Forma]
Clave=RepVentaAcum
Nombre=Acumulados - Ventas
Icono=0
Modulos=(Todos)
ListaCarpetas=(Variables)
CarpetaPrincipal=(Variables)
PosicionInicialIzquierda=334
PosicionInicialArriba=325
PosicionInicialAltura=118
PosicionInicialAncho=355
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
AccionesTamanoBoton=25x5
ListaAcciones=(Lista)
AccionesCentro=S
AccionesDivision=S
BarraHerramientas=S
VentanaEscCerrar=S

VentanaEstadoInicial=Normal
VentanaExclusivaOpcion=4
ExpresionesAlMostrar=Asigna(Info.Articulo, Nulo)<BR>Asigna(Info.Cliente, Nulo)<BR>Asigna(Info.Ejercicio, EjercicioTrabajo)<BR>Asigna(Info.Desglosar, <T>No<T>)
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
ListaEnCaptura=(Lista)
CarpetaVisible=S

[(Variables).Info.Articulo]
Carpeta=(Variables)
Clave=Info.Articulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20

[(Variables).Info.Ejercicio]
Carpeta=(Variables)
Clave=Info.Ejercicio
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=10
Pegado=N

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreDesplegar=&Preliminar
Multiple=S
EnBarraAcciones=S
Activo=S
Visible=S
ListaAccionesMultiples=Variables Asignar<BR>Ir<BR>VerAcum
NombreEnBoton=S
EnBarraHerramientas=S

[Acciones.RepPan.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.RepPan.Ir]
Nombre=Ir
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=IrEjercicio(Info.Ejercicio)<BR>IrDireccion(<T>VTAS<T>, Info.Articulo, Info.Cliente, Si(ConDatos(Info.Cliente),Falso,Info.Desglosar<><T>No<T>))

[Acciones.RepPan.VerAcum]
Nombre=VerAcum
Boton=0
TipoAccion=Reportes Pantalla
ClaveAccion=VerAcum
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
ListaAccionesMultiples=Variables Asignar<BR>Ir<BR>VerAcum
Activo=S
Visible=S
NombreEnBoton=S
EnBarraHerramientas=S
EspacioPrevio=S

[Acciones.Imprimir.Ir]
Nombre=Ir
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=IrEjercicio(Info.Ejercicio)<BR>IrDireccion(<T>VTAS<T>, Info.Articulo, Info.Cliente, Si(ConDatos(Info.Cliente),Falso,Info.Desglosar<><T>No<T>))

[Acciones.Imprimir.VerAcum]
Nombre=VerAcum
Boton=0
TipoAccion=Reportes Impresora
ClaveAccion=VerAcum
Activo=S
Visible=S

[(Variables).Info.Cliente]
Carpeta=(Variables)
Clave=Info.Cliente
Editar=S
ValidaNombre=S
3D=S
Tamano=20
LineaNueva=S

[(Variables).Info.Desglosar]
Carpeta=(Variables)
Clave=Info.Desglosar
Editar=S
ValidaNombre=S
3D=S
Tamano=10
Pegado=N

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


[(Variables).ListaEnCaptura]
(Inicio)=Info.Articulo
Info.Articulo=Info.Ejercicio
Info.Ejercicio=Info.Cliente
Info.Cliente=Info.Desglosar
Info.Desglosar=(Fin)



[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Imprimir
Imprimir=RepPan
RepPan=(Fin)
