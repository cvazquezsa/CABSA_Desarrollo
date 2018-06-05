
[Forma]
Clave=InformeDineroAux
Icono=0
BarraHerramientas=S
Modulos=(Todos)
Nombre=Tesorería - Auxiliar Movimientos
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaCarpetas=(Lista)
CarpetaPrincipal=Lista
PosicionInicialAlturaCliente=290
PosicionInicialAncho=332
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=634
PosicionInicialArriba=271
ListaAcciones=(Lista)
[Lista]
Estilo=Ficha
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=INformeDineroAux
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

Pestana=S
PestanaOtroNombre=S
PestanaNombre=Filtro
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=RepParam.Estacion = {EstacionTrabajo}
FiltroRespetar=S
FiltroTipo=General
[Lista.RepParam.InfoMov]
Carpeta=Lista
Clave=RepParam.InfoMov
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.RepParam.InfoMoneda]
Carpeta=Lista
Clave=RepParam.InfoMoneda
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.RepParam.InfoFechaD]
Carpeta=Lista
Clave=RepParam.InfoFechaD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Lista.RepParam.InfoFechaA]
Carpeta=Lista
Clave=RepParam.InfoFechaA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
ColorFondo=Blanco

Tamano=20
[Lista.RepParam.InfoCtaDineroD]
Carpeta=Lista
Clave=RepParam.InfoCtaDineroD
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.RepParam.InfoCtaDineroA]
Carpeta=Lista
Clave=RepParam.InfoCtaDineroA
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.RepParam.InfoNivel]
Carpeta=Lista
Clave=RepParam.InfoNivel
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.RepParam.InfoTitulo]
Carpeta=Lista
Clave=RepParam.InfoTitulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=41
ColorFondo=Blanco

[Lista.RepParam.InfoUso]
Carpeta=Lista
Clave=RepParam.InfoUso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
GuardarAntes=S
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
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S



EspacioPrevio=S















































GuardarAntes=S
Expresion=Si InformeDineroAux:RepParam.InfoNivel = <T>Desglosado<T> Entonces<BR>  GuardarCambios<BR>  Informe(<T>InformeDineroAux<T>,InformeDineroAux:RepParam.InfoTitulo)<BR>Fin<BR>Si InformeDineroAux:RepParam.InfoNivel = <T>Concentrado<T> Entonces<BR>  GuardarCambios<BR>  Informe(<T>InformeDineroAuxConcentrado<T>,InformeDineroAux:RepParam.InfoTitulo)<BR>Fin<BR>Si InformeDineroAux:RepParam.InfoNivel = <T>Desglosado por Dia<T> Entonces<BR>  GuardarCambios<BR>  Informe(<T>InformeDineroAuxDia<T>,InformeDineroAux:RepParam.InfoTitulo)<BR>Fin<BR>Si InformeDineroAux:RepParam.InfoNivel = <T>Desglosado/Origen<T> Entonces<BR>  GuardarCambios<BR>  Informe(<T>InformeDineroAuxOrigen<T>,InformeDineroAux:RepParam.InfoTitulo)<BR>Fin
[Grafica]
Estilo=Ficha
Pestana=S
PestanaOtroNombre=S
PestanaNombre=Gráfica
Clave=Grafica
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RepParam
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=130
FichaNombres=Izquierda
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
[Grafica.RepParam.InformeGraficarTipo]
Carpeta=Grafica
Clave=RepParam.InformeGraficarTipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Grafica.RepParam.InformeGraficarCantidad]
Carpeta=Grafica
Clave=RepParam.InformeGraficarCantidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco


[Lista.Columnas]
0=84
1=111
2=-2






[Lista.ListaEnCaptura]
(Inicio)=RepParam.InfoCtaDineroD
RepParam.InfoCtaDineroD=RepParam.InfoCtaDineroA
RepParam.InfoCtaDineroA=RepParam.InfoFechaD
RepParam.InfoFechaD=RepParam.InfoFechaA
RepParam.InfoFechaA=RepParam.InfoUso
RepParam.InfoUso=RepParam.InfoMov
RepParam.InfoMov=RepParam.InfoNivel
RepParam.InfoNivel=RepParam.InfoMoneda
RepParam.InfoMoneda=RepParam.InfoTitulo
RepParam.InfoTitulo=(Fin)














[Grafica.RepParam.VerGraficaDetalle]
Carpeta=Grafica
Clave=RepParam.VerGraficaDetalle
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco















[Grafica.ListaEnCaptura]
(Inicio)=RepParam.InformeGraficarTipo
RepParam.InformeGraficarTipo=RepParam.InformeGraficarCantidad
RepParam.InformeGraficarCantidad=RepParam.VerGraficaDetalle
RepParam.VerGraficaDetalle=(Fin)



[Forma.ListaCarpetas]
(Inicio)=Lista
Lista=Grafica
Grafica=(Fin)

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Preliminar
Preliminar=(Fin)
