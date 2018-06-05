
[Forma]
Clave=GuatemalaLibroVenta
Icono=0
Modulos=(Todos)
Nombre=Libro Venta

ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=464
PosicionInicialArriba=180
PosicionInicialAlturaCliente=115
PosicionInicialAncho=255
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Ficha]
Estilo=Ficha
Clave=Ficha
Filtros=S
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

FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
CarpetaVisible=S
PermiteEditar=S

FiltroGeneral=RepParam.Estacion = {EstacionTrabajo}
[Ficha.RepParam.InfoEjercicio]
Carpeta=Ficha
Clave=RepParam.InfoEjercicio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco


[Ficha.RepParam.InfoLineasPorPagina]
Carpeta=Ficha
Clave=RepParam.InfoLineasPorPagina
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco




[Acciones.Cerrar]
Nombre=Cerrar
Boton=36
NombreEnBoton=S
NombreDesplegar=&Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.RepPan]
Nombre=RepPan
Boton=6
NombreEnBoton=S
NombreDesplegar=&Vista Preliminar
EnBarraHerramientas=S
TipoAccion=Reportes Pantalla
ClaveAccion=GuatemalaLibroVenta
Activo=S
Visible=S

EspacioPrevio=S


GuardarAntes=S



Antes=S
AntesExpresiones=Asigna(Info.Periodo,RepParam.InfoPeriodoD)<BR>Asigna(Info.Ejercicio,RepParam.InfoEjercicio)
[Acciones.Imprimir]
Nombre=Imprimir
Boton=4
NombreEnBoton=S
NombreDesplegar=&Imprimir
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Reportes Impresora
ClaveAccion=GuatemalaLibroVenta
Activo=S
Visible=S





[Ficha.RepParam.InfoPeriodoD]
Carpeta=Ficha
Clave=RepParam.InfoPeriodoD
Editar=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco










[Ficha.ListaEnCaptura]
(Inicio)=RepParam.InfoEjercicio
RepParam.InfoEjercicio=RepParam.InfoPeriodoD
RepParam.InfoPeriodoD=RepParam.InfoLineasPorPagina
RepParam.InfoLineasPorPagina=(Fin)























[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=RepPan
RepPan=Imprimir
Imprimir=(Fin)
