[Forma]
Clave=ConceptoVtas
Nombre=<T>Conceptos - <T>+Info.Descripcion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=235
PosicionInicialArriba=163
PosicionInicialAltura=400
PosicionInicialAncho=810
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
ExpresionesAlMostrar=
ExpresionesAlCerrar=
PosicionInicialAlturaCliente=373

Comentarios=//MEJORA10041
[Lista]
Estilo=Hoja
Clave=Lista
Filtros=S
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Concepto
Fuente={MS Sans Serif, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
FiltroPredefinido=S
FiltroAncho=30
FiltroTipo=General
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroNullNombre=(sin clasificar)
FiltroRespetar=S
CarpetaVisible=S
OtroOrden=S
ListaOrden=Concepto.Orden<TAB>(Acendente)
PermiteLocalizar=S
HojaAjustarColumnas=S
HojaMantenerSeleccion=S

FiltroGeneral=Concepto.Modulo=<T>{Info.Modulo}<T>
[Lista.Concepto.Concepto]
Carpeta=Lista
Clave=Concepto.Concepto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Lista.Columnas]
Concepto=177
Bloqueo=90
Orden=36
EsDeducible=51
ConSueldo=88
Cuenta=112
Impuestos=46
Retencion=86
Retencion2=86
Clase=88
SubClase=79
ValidarPresupuesto=75
Tipo=47
Actividad=71
PorcentajeDeducible=64
CR=123
NivelAcceso=100
UEN=39
Retencion3=75
CuentaPresupuesto=103
Numero=44

TipoImpuesto1=81
[Acciones.Guardar]
Nombre=Guardar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Concepto.Bloqueo]
Carpeta=Lista
Clave=Concepto.Bloqueo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco

[Acciones.Excel]
Nombre=Excel
Boton=67
NombreDesplegar=Excel
EnBarraHerramientas=S
Carpeta=(Carpeta principal)
TipoAccion=Controles Captura
ClaveAccion=Enviar/Recibir Excel
Visible=S
ActivoCondicion=Usuario.EnviarExcel

[Lista.Concepto.Cuenta]
Carpeta=Lista
Clave=Concepto.Cuenta
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Acciones.Ordenar]
Nombre=Ordenar
Boton=50
NombreDesplegar=Cambiar &Orden
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Controles Captura
ClaveAccion=Actualizar Forma
Activo=S
Visible=S
Antes=S
AntesExpresiones=Forma(<T>ConceptoOrdenar<T>)

[Lista.Concepto.Impuestos]
Carpeta=Lista
Clave=Concepto.Impuestos
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Concepto.Retencion]
Carpeta=Lista
Clave=Concepto.Retencion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Concepto.Retencion2]
Carpeta=Lista
Clave=Concepto.Retencion2
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Concepto.CR]
Carpeta=Lista
Clave=Concepto.CR
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Concepto.NivelAcceso]
Carpeta=Lista
Clave=Concepto.NivelAcceso
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Concepto.UEN]
Carpeta=Lista
Clave=Concepto.UEN
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.ConceptoAcceso]
Nombre=ConceptoAcceso
Boton=80
NombreEnBoton=S
NombreDesplegar=Acceso &Especifico
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ConceptoAcceso
Antes=S
Visible=S
EspacioPrevio=S
ActivoCondicion=Concepto:Concepto.NivelAcceso=<T>(Especifico)<T>
AntesExpresiones=Asigna(Info.Concepto, Concepto:Concepto.Concepto)

[Lista.Concepto.Retencion3]
Carpeta=Lista
Clave=Concepto.Retencion3
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Acciones.Politica]
Nombre=Politica
Boton=22
NombreEnBoton=S
NombreDesplegar=&Política
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=ConceptoPolitica
Activo=S
Antes=S
Visible=S
EspacioPrevio=S
AntesExpresiones=Asigna(Info.Concepto, Concepto:Concepto.Concepto)

[Lista.Concepto.CuentaPresupuesto]
Carpeta=Lista
Clave=Concepto.CuentaPresupuesto
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Concepto.Numero]
Carpeta=Lista
Clave=Concepto.Numero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco

[Lista.Concepto.Clase]
Carpeta=Lista
Clave=Concepto.Clase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.Concepto.SubClase]
Carpeta=Lista
Clave=Concepto.SubClase
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



[Acciones.RegimenFiscal]
Nombre=RegimenFiscal
Boton=47
NombreEnBoton=S
NombreDesplegar=&Régimen Fiscal
EnBarraHerramientas=S
TipoAccion=Formas
ClaveAccion=CFDFlexConcepto
Activo=S
Visible=S















Antes=S






























EspacioPrevio=S






GuardarAntes=S
AntesExpresiones=Asigna(Info.Concepto,Concepto:Concepto.Concepto)






[Lista.Concepto.TipoImpuesto1]
Carpeta=Lista
Clave=Concepto.TipoImpuesto1
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco


[TipoImpuesto1.Columnas]
0=-2
1=88
2=277
3=-2












[Lista.ListaEnCaptura]
(Inicio)=Concepto.Concepto
Concepto.Concepto=Concepto.CR
Concepto.CR=Concepto.Bloqueo
Concepto.Bloqueo=Concepto.Cuenta
Concepto.Cuenta=Concepto.CuentaPresupuesto
Concepto.CuentaPresupuesto=Concepto.Impuestos
Concepto.Impuestos=Concepto.Retencion
Concepto.Retencion=Concepto.Retencion2
Concepto.Retencion2=Concepto.Retencion3
Concepto.Retencion3=Concepto.NivelAcceso
Concepto.NivelAcceso=Concepto.UEN
Concepto.UEN=Concepto.Clase
Concepto.Clase=Concepto.SubClase
Concepto.SubClase=Concepto.Numero
Concepto.Numero=Concepto.TipoImpuesto1
Concepto.TipoImpuesto1=(Fin)





[Forma.ListaAcciones]
(Inicio)=Guardar
Guardar=Politica
Politica=ConceptoAcceso
ConceptoAcceso=Ordenar
Ordenar=Excel
Excel=RegimenFiscal
RegimenFiscal=(Fin)
