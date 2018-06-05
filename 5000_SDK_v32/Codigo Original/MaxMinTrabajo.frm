
[Forma]
Clave=MaxMinTrabajo
Icono=0
Modulos=(Todos)
MovModulo=MaxMinTrabajo
Nombre=Configuración del Trabajo

ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=559
PosicionInicialArriba=259
PosicionInicialAlturaCliente=209
PosicionInicialAncho=478
VentanaTipoMarco=Normal
VentanaPosicionInicial=por Diseño
VentanaEstadoInicial=Normal
ExpresionesAlMostrar=ActualizarForma
[Lista]
Estilo=Ficha
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MaxMinTrabajo
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

RefrescarAlEntrar=S
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
[Lista.MaxMinTrabajo.Trabajo]
Carpeta=Lista
Clave=MaxMinTrabajo.Trabajo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MaxMinTrabajo.Frecuencia]
Carpeta=Lista
Clave=MaxMinTrabajo.Frecuencia
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MaxMinTrabajo.Valor]
Carpeta=Lista
Clave=MaxMinTrabajo.Valor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.MaxMinTrabajo.Activo]
Carpeta=Lista
Clave=MaxMinTrabajo.Activo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Guardar y Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

GuardarAntes=S


[Acciones.CrearTrabajo]
Nombre=CrearTrabajo
Boton=7
NombreEnBoton=S
NombreDesplegar=&Ejecutar
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S




























































GuardarAntes=S
Expresion=ProcesarSQL(<T>spMaxMinCrearJob :tNombre,:tBaseDatos,:tEmpresa<T>, MaxMinTrabajo:MaxMinTrabajo.Trabajo, BaseDatos, Empresa)
[Lista.ListaEnCaptura]
(Inicio)=MaxMinTrabajo.Trabajo
MaxMinTrabajo.Trabajo=MaxMinTrabajo.Frecuencia
MaxMinTrabajo.Frecuencia=MaxMinTrabajo.Valor
MaxMinTrabajo.Valor=MaxMinTrabajo.Activo
MaxMinTrabajo.Activo=(Fin)























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=CrearTrabajo
CrearTrabajo=(Fin)
