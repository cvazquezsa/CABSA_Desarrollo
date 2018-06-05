
[Forma]
Clave=RepGastoPresupuestoGastado
Icono=0
Modulos=(Todos)
Nombre=Presupuestado vs Gastado

ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=566
PosicionInicialArriba=377
PosicionInicialAlturaCliente=118
PosicionInicialAncho=307
ListaAcciones=(Lista)
VentanaExclusiva=S
VentanaExclusivaOpcion=4
[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
Fuente={Tahoma, 8, Negro, []}
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

[Ficha.RepParam.InfoFechaD]
Carpeta=Ficha
Clave=RepParam.InfoFechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RepParam.InfoFechaA]
Carpeta=Ficha
Clave=RepParam.InfoFechaA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.RepParam.InfoConcepto]
Carpeta=Ficha
Clave=RepParam.InfoConcepto
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

LineaNueva=S

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

[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreEnBoton=S
NombreDesplegar=&Preliminar
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Pantalla
ClaveAccion=RepGastoPresupuestoGastado
Activo=S
Visible=S


[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreEnBoton=S
NombreDesplegar=&Imprimir
EnBarraHerramientas=S
TipoAccion=Reportes Impresora
ClaveAccion=RepGastoPresupuestoGastado
Activo=S
Visible=S






[Lista.Columnas]
Concepto=218














[Ficha.ListaEnCaptura]
(Inicio)=RepParam.InfoFechaD
RepParam.InfoFechaD=RepParam.InfoFechaA
RepParam.InfoFechaA=RepParam.InfoConcepto
RepParam.InfoConcepto=RepParam.InfoMoneda
RepParam.InfoMoneda=(Fin)

[Ficha.RepParam.InfoMoneda]
Carpeta=Ficha
Clave=RepParam.InfoMoneda
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro





























[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Preliminar
Preliminar=Imprimir
Imprimir=(Fin)
