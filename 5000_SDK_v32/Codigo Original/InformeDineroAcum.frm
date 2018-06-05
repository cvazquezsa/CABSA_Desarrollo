
[Forma]
Clave=InformeDineroAcum
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Tesorería - Acumulado Movimientos
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=166
PosicionInicialAncho=316
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=642
PosicionInicialArriba=333
ListaAcciones=(Lista)
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

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=RepParam.Estacion = {EstacionTrabajo}
[Ficha.RepParam.InfoCtaDineroD]
Carpeta=Ficha
Clave=RepParam.InfoCtaDineroD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoCtaDineroA]
Carpeta=Ficha
Clave=RepParam.InfoCtaDineroA
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoMoneda]
Carpeta=Ficha
Clave=RepParam.InfoMoneda
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Ficha.RepParam.InfoEjercicio]
Carpeta=Ficha
Clave=RepParam.InfoEjercicio
Editar=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Acciones.Preliminar]
Nombre=Preliminar
Boton=6
NombreDesplegar=&Preliminar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
NombreEnBoton=S

EspacioPrevio=S
GuardarAntes=S
Expresion=Asigna(RepParam:RepParam.RepTitulo, <T>Tesorería - Acumulado Movimientos<T>)<BR>GuardarCambios<BR>Informe( <T>InformeDineroAcum<T>,RepParam:RepParam.RepTitulo)
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



























[Lista.Columnas]
0=84
1=111
2=-2




[Ficha.ListaEnCaptura]
(Inicio)=RepParam.InfoCtaDineroD
RepParam.InfoCtaDineroD=RepParam.InfoCtaDineroA
RepParam.InfoCtaDineroA=RepParam.InfoMoneda
RepParam.InfoMoneda=RepParam.InfoEjercicio
RepParam.InfoEjercicio=RepParam.InfoTitulo
RepParam.InfoTitulo=(Fin)

[Ficha.RepParam.InfoTitulo]
Carpeta=Ficha
Clave=RepParam.InfoTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

















[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Preliminar
Preliminar=(Fin)
