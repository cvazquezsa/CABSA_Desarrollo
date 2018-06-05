
[Forma]
Clave=RepProductividadWMS
Icono=0
Modulos=(Todos)
Nombre=Reporte de Productividad

ListaCarpetas=RepParam
CarpetaPrincipal=RepParam
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
PosicionInicialAlturaCliente=96
PosicionInicialAncho=400
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=600
PosicionInicialArriba=383




ListaAcciones=(Lista)
[(Variables).ListaEnCaptura]
(Inicio)=Info.Agente
Info.Agente=Info.FechaD
Info.FechaD=Info.FechaA
Info.FechaA=(Fin)

[Lista.Columnas]
0=105
1=247

[RepParam]
Estilo=Ficha
Clave=RepParam
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
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
ListaEnCaptura=(Lista)


[RepParam.RepParam.InfoAcomodador]
Carpeta=RepParam
Clave=RepParam.InfoAcomodador
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[RepParam.RepParam.InfoFechaD]
Carpeta=RepParam
Clave=RepParam.InfoFechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[RepParam.RepParam.InfoFechaA]
Carpeta=RepParam
Clave=RepParam.InfoFechaA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=15
[RepParam.RepParam.InfoFlujo]
Carpeta=RepParam
Clave=RepParam.InfoFlujo
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco




[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
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
ClaveAccion=RepProductividadWMS
Activo=S
Visible=S


Antes=S
AntesExpresiones=Asigna(Info.EstacionTrabajo,RepParam:RepParam.Estacion)
[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreEnBoton=S
NombreDesplegar=&Imprimir
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Reportes Impresora
ClaveAccion=RepProductividadWMS
Activo=S
Visible=S








Antes=S
AntesExpresiones=Asigna(Info.EstacionTrabajo,RepParam:RepParam.Estacion)
[RepParam.ListaEnCaptura]
(Inicio)=RepParam.InfoAcomodador
RepParam.InfoAcomodador=RepParam.InfoFlujo
RepParam.InfoFlujo=RepParam.InfoFechaD
RepParam.InfoFechaD=RepParam.InfoFechaA
RepParam.InfoFechaA=(Fin)

































































































[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Preliminar
Preliminar=Imprimir
Imprimir=(Fin)
