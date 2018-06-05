[Forma]
Clave=Evaluaciones
Nombre=Evaluaciones
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=Cerrar
PosicionInicialAltura=307
PosicionInicialAncho=698
EsConsultaExclusiva=S
PosicionInicialIzquierda=291
PosicionInicialArriba=358
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
PosicionInicialAlturaCliente=280

[Lista]
Estilo=Iconos
Clave=Lista
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=RHEvaluacion
Fuente={MS Sans Serif, 8, Negro, []}
IconosCampo=(sin Icono)
IconosEstilo=Detalles
IconosAlineacion=de Arriba hacia Abajo
IconosConSenales=S
IconosSubTitulo=<T>Evaluación<T>
ElementosPorPagina=200
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S
PestanaOtroNombre=S
PestanaNombre=Evaluaciones
IconosNombre=RHEvaluacion:RH.Evaluacion

[Lista.RHD.Calificacion]
Carpeta=Lista
Clave=RHD.Calificacion
Editar=S
Totalizador=2
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RH.FechaEmision]
Carpeta=Lista
Clave=RH.FechaEmision
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro

[Lista.RHD.Observaciones]
Carpeta=Lista
Clave=RHD.Observaciones
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Evaluacion.Tipo]
Carpeta=Lista
Clave=Evaluacion.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
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

[Lista.Columnas]
0=182
1=67

[Lista.ListaEnCaptura]
(Inicio)=RHD.Calificacion
RHD.Calificacion=RH.FechaEmision
RH.FechaEmision=RHD.Observaciones
RHD.Observaciones=Evaluacion.Tipo
Evaluacion.Tipo=(Fin)
