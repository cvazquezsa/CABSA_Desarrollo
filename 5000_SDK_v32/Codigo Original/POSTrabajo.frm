
[Forma]
Clave=POSTrabajo
Icono=0
CarpetaPrincipal=POSTrabajo
Modulos=(Todos)
Nombre=POS JOB
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S

ListaAcciones=(Lista)
ListaCarpetas=POSTrabajo
PosicionInicialIzquierda=456
PosicionInicialArriba=274
PosicionInicialAlturaCliente=273
PosicionInicialAncho=687
[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[POSTrabajo]
Estilo=Ficha
Clave=POSTrabajo
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=POSTrabajo
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

[POSTrabajo.POSTrabajo.Trabajo]
Carpeta=POSTrabajo
Clave=POSTrabajo.Trabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[POSTrabajo.POSTrabajo.Frecuencia]
Carpeta=POSTrabajo
Clave=POSTrabajo.Frecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[POSTrabajo.POSTrabajo.Valor]
Carpeta=POSTrabajo
Clave=POSTrabajo.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSTrabajo.POSTrabajo.Activo]
Carpeta=POSTrabajo
Clave=POSTrabajo.Activo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[POSTrabajo.ListaEnCaptura]
(Inicio)=POSTrabajo.Trabajo
POSTrabajo.Trabajo=POSTrabajo.Frecuencia
POSTrabajo.Frecuencia=POSTrabajo.Valor
POSTrabajo.Valor=POSTrabajo.Activo
POSTrabajo.Activo=(Fin)

[Acciones.Generar]
Nombre=Generar
Boton=7
NombreEnBoton=S
NombreDesplegar=&Generar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S



EspacioPrevio=S


















Expresion=ProcesarSQL(<T>spPOSCrearJob :tNombre,:tBaseDatos<T>,POSTrabajo:POSTrabajo.Trabajo,BaseDatos)
ConCondicion=S
EjecucionCondicion=(ConDatos(POSTrabajo:POSTrabajo.Trabajo)) y  (ConDatos(POSTrabajo:POSTrabajo.Frecuencia))y(ConDatos(POSTrabajo:POSTrabajo.Valor))


























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Generar
Generar=(Fin)
