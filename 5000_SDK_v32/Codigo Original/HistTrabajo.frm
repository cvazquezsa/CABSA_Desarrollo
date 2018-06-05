
[Forma]
Clave=HistTrabajo
Icono=0
Modulos=(Todos)
MovModulo=(Todos)
Nombre=Crear Trabajo Históricos

ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=418
PosicionInicialArriba=246
PosicionInicialAlturaCliente=273
PosicionInicialAncho=500
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
[Lista]
Estilo=Ficha
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=HistTrabajo
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
ListaEnCaptura=(Lista)

CarpetaVisible=S

[Lista.HistTrabajo.Trabajo]
Carpeta=Lista
Clave=HistTrabajo.Trabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.HistTrabajo.Frecuencia]
Carpeta=Lista
Clave=HistTrabajo.Frecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.HistTrabajo.Valor]
Carpeta=Lista
Clave=HistTrabajo.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.HistTrabajo.Activo]
Carpeta=Lista
Clave=HistTrabajo.Activo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco



[Lista.ListaEnCaptura]
(Inicio)=HistTrabajo.Trabajo
HistTrabajo.Trabajo=HistTrabajo.Frecuencia
HistTrabajo.Frecuencia=HistTrabajo.Valor
HistTrabajo.Valor=HistTrabajo.Activo
HistTrabajo.Activo=(Fin)

[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.CrearTrabajo]
Nombre=CrearTrabajo
Boton=7
NombreDesplegar=&Generar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S





NombreEnBoton=S
GuardarAntes=S




ConCondicion=S
















Expresion=ProcesarSQL(<T>spHistCrearJob :tNombre,:tBaseDatos<T>,HistTrabajo:HistTrabajo.Trabajo,BaseDatos)
EjecucionCondicion=(ConDatos(HistTrabajo:HistTrabajo.Trabajo)) y  (ConDatos(HistTrabajo:HistTrabajo.Frecuencia))y(ConDatos(HistTrabajo:HistTrabajo.Valor))














[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=CrearTrabajo
CrearTrabajo=(Fin)
